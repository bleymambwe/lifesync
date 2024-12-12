import firebase_admin
from firebase_admin import credentials, db
from credentials import credentials_info, databaseURL

from drug_substitute import DrugSubstitute 
from model import LifeSync
from prompt import lifesync_template, lifesync_role
from get_condition import get_user_details

# Initialize Firebase Admin SDK using the credentials from credentials.py
cred = credentials.Certificate(credentials_info)
firebase_admin.initialize_app(cred, {
    'databaseURL': databaseURL
})

def on_post_created(event, context):
    # Get the delta which contains only the new changes
    delta = event.get('delta', {})
    if not delta:
        print("No delta found in event")
        return
    template = lifesync_template
    role = lifesync_role
    
    # Extract the post data
    post_section = delta.get('post', {})
    if not post_section:
        print("No post section found in delta")
        return
    
    # Get the most recent entry (should be only one in delta)
    # Convert post_section items to list and get the first item's data
    try:
        latest_key = list(post_section.keys())[0]
        latest_data = post_section[latest_key]
        
        print(f"Processing latest data: {latest_data}")
        
        # Get the feature type 
        feature = latest_data.get('feature', '')
        prompt = latest_data.get('prompt', '')  # or 'prompt' depending on your exact key
        
        # If feature is 'ai', print 'Executing function'
        if feature == 'ai':
            print('Executing function')
            model = LifeSync(role=role, template=template, model='gpt-4o')
            model.stream_response(prompt=prompt)
        elif feature == 'drug substitute':
            print('Executing Drug substitute')
            model = DrugSubstitute()
            model.substitute_drug(drug_name=prompt)

        elif feature == 'call':
            print('Executing LifeSync call')
            #phone_number, condition = get_user_details() 
            model = LifeSync(role=role, template=template, model='gpt-4o')
            model.stream_phonecall()
            #model.checkdb()
        else:
            print('feature not found')
        
        # Print the list of [prompt, feature]
        print([prompt, feature])
    
    except IndexError:
        print("No entries found in post section")
    except Exception as e:
        print(f"Error processing event: {e}")