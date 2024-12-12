import os
import pickle
import requests

from langchain.document_loaders import UnstructuredURLLoader
from langchain.document_loaders import SeleniumURLLoader
from langchain.text_splitter import CharacterTextSplitter

# from langchain.vectorstores import FAISS
# from langchain.embeddings import OpenAIEmbeddings

from langchain.llms import OpenAI
from langchain.chat_models import ChatOpenAI
from langchain.prompts import ChatPromptTemplate
from langchain.chains import RetrievalQAWithSourcesChain
from langchain.prompts import HumanMessagePromptTemplate
from langchain.schema.messages import SystemMessage

from langchain.docstore.document import Document
import firebase_admin
from firebase_admin import credentials, db

from firebase import firebase

class LifeSync:
  def __init__(self,model, role,template, max_tokens = 665):
      self.role = role
      self.template = template
      self.chat_model = model
    
      self.openai_api_key = os.environ.get('OPENAI_API')
      self.bland_api_key = os.environ.get('BLAND_API')
      # self.sightengine_api_key = os.environ.get('SIGHTENGINE_API')
      self.llm = self.create_llm(max_tokens)
      self.format_template = self.create_format_template()

      self.firebase_path = '/user/response/main'
      self.firebase_call_path = '/user/response/call'

      self.trigger_model = 'streaming'
      self.firebase_instance_url = os.environ.get('FIREBASE_URL')

      self.firebase = firebase.FirebaseApplication(self.firebase_instance_url, None)

      self.headers = {
             "authorization": self.bland_api_key,
              "Content-Type": "application/json"}


  def create_format_template(self):
      return ChatPromptTemplate.from_messages([
          SystemMessage(content=self.role),
          HumanMessagePromptTemplate.from_template(self.template),
      ])
  def create_llm(self,max_tokens):  
      api_key = self.openai_api_key  
      return ChatOpenAI(model=self.chat_model,openai_api_key=api_key,max_tokens=max_tokens)

  def predict(self,prompt):
      formated_prompt = self.format_template.format_messages(lifesync_role=role, lifesync_template =template,prompt= prompt )
      response = self.llm(formated_prompt)
      self.response = response.content
      return self.response

  def stream_response(self, prompt):

      """
      Stream the response and update Firebase in real-time.

      Args:
          prompt (str): The input prompt to generate a response for

      Returns:
          str: The complete generated response
      """
      try:
          formatted_prompt = self.format_template.format_messages(
              lifesync_role=self.role,  # Use self.role instead of global role
              lifesync_template=self.template,  # Use self.template instead of global template
              prompt=prompt
          )
          response = ''

          # The path should match exactly with the Flutter code


          for chunk in self.llm.stream(formatted_prompt):
              response += chunk.content
              print(response)  # For debugging

              # Update Firebase with the current response
              try:
                  self.firebase.put(self.firebase_path, 'response', response)
              except Exception as e:
                  print(f"Firebase update error: {str(e)}")

          return response

      except Exception as e:
          print(f"Streaming error: {str(e)}")
          raise e

  def stream_call(self, phone_number,prompt):  
    bland_url = 'https://api.bland.ai/call'
    bland_role = '''
    State your name LifeSync AI, and that you are a health advisor to provide personalised health care based on your underlying condition
    '''
    formated_prompt = bland_role +self.template + prompt
    payload = {
    "phone_number":phone_number,
    "from": None,
    "task": formated_prompt,
    "voice": "Maya",  # "Derek",
    "wait_for_greeting": False,
    "record": False,
    "local_dialing": False,
    "answered_by_enabled": False,
    "interruption_threshold": "50",
    "temperature": None,
    "transfer_phone_number": None,
    "first_sentence": None,
    "max_duration": 12,
    "model": "turbo",
    "language": "eng",
    "start_time": None,
    "webhook": None,
    "pronunciation_guide": []}

    response = requests.request("POST", bland_url, json=payload, headers=self.headers)
    response = str(response)
    #Update Firebase with the current response
    try:
        self.firebase.put(self.firebase_path, 'response', response)
    except Exception as e:
        print(f"Firebase update error: {str(e)}")

  def checkdb(self):
    try:
        # Retrieve data from Firebase under the 'user/details' node
        user_details = self.firebase.get('user' + '/details', None)
        
        # Check if the data exists and print it
        if user_details:
            # Extract phone number and condition
            self.phone_number = user_details.get('user_details', {}).get('contact', 'Not Available')
            self.condition = user_details.get('user_details', {}).get('condition', 'Not Available')
            
            print("Phone Number: ", self.phone_number)
            print("Condition: ", self.condition)
        else:
            print("No user details found.")
        
    except Exception as e:
        print(f"Error retrieving data from Firebase: {str(e)}")



  def stream_phonecall(self):  
    bland_url = 'https://api.bland.ai/call'
    bland_role = '''
    State your name LifeSync AI, and that you are a health advisor to provide personalised health care based on your underlying condition
    '''
    self.checkdb()
    prompt = self.condition
    phone_number= self.phone_number

    formated_prompt = bland_role + self.template + prompt
    payload = {
        "phone_number": phone_number,
        "from": None,
        "task": formated_prompt,
        "voice": "Maya",  # "Derek",
        "wait_for_greeting": False,
        "record": False,
        "local_dialing": False,
        "answered_by_enabled": False,
        "interruption_threshold": "80",
        "temperature": None,
        "transfer_phone_number": None,
        "first_sentence": None,
        "max_duration": 12,
        "model": "turbo",
        "language": "eng",
        "start_time": None,
        "webhook": None,
        "pronunciation_guide": []
    }
    
    print('About to make call...')
    
    try:
        # Make the API call
        response = requests.request("POST", bland_url, json=payload, headers=self.headers)
        
        # Log based on the response status code
        if response.status_code == 200:
            message = "I enjoyed talking to you 😊, we should do this again!"
        elif response.status_code == 400:
            message = f"Phone Call Error: Bad Request : {response.text}"
        elif response.status_code == 401:
            message = f"Unauthorized : {response.text}"
        elif response.status_code == 404:
            message = f"Not Found : {response.text}"
        elif response.status_code == 500:
            message = f"Internal Server Error:{response.text} "
        else:
            message = f"Unexpected Status Code: {response.status_code},{response.text}"
        
        # Log to Firebase and print the message
        try:
            self.firebase.put(self.firebase_call_path, 'response', message)
            print(message)
        except Exception as firebase_error:
            print(f"Firebase update error: {str(firebase_error)}")
    
    except requests.exceptions.RequestException as request_error:
        error_message = f"Request failed: {str(request_error)}"
        print(error_message)
        
        # Log the error to Firebase
        try:
            self.firebase.put(self.firebase_call_path, 'response', error_message)
            print(error_message)
        except Exception as firebase_error:
            print(f"Firebase update error: {str(firebase_error)}")

