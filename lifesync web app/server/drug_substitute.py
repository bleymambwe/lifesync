import os
import requests
import firebase_admin
from firebase_admin import credentials, db
from firebase import firebase

class DrugSubstitute:
    def __init__(self):
        """
        Initialize DrugSubstitute with Firebase configuration
 
        """
        # Firebase configuration
        self.firebase_path = '/user/response/drug_substitute'
        self.firebase_instance_url = os.environ.get('FIREBASE_URL')
        self.firebase = firebase.FirebaseApplication(self.firebase_instance_url, None)


    def rxnorm_drug_alternatives(self, rxcui):
        """
        Find drug alternatives using RxNorm API
        
        :param rxcui: RxNorm Concept Unique Identifier for the original drug
        :return: Dictionary of alternative medications
        """
        base_url = f"https://rxnav.nlm.nih.gov/REST/rxcui/{rxcui}/related.json"
        
        try:
            # Make the API request
            response = requests.get(base_url)
            response.raise_for_status()
            
            # Parse the JSON response
            data = response.json()
            
            # Extract alternative medications
            alternatives = []
            
            # Check different types of related concepts
            related_group = data.get('relatedGroup', {})
            concept_groups = related_group.get('conceptGroup', [])
            
            for group in concept_groups:
                concept_properties = group.get('conceptProperties', [])
                for prop in concept_properties:
                    alternatives.append({
                        'rxcui': prop.get('rxcui', 'N/A'),
                        'name': prop.get('name', 'N/A'),
                        'synonym': prop.get('synonym', 'N/A'),
                        'tty': prop.get('tty', 'N/A')  # Vocabulary term type
                    })
            
            return {
                'original_drug_rxcui': rxcui,
                'alternatives': alternatives
            }
        
        except requests.RequestException as e:
            return {"error": f"API request failed: {str(e)}"}
    
    def open_fda_drug_substitution(self, drug_name):
        """
        Find potential drug substitutes using OpenFDA API
        
        :param drug_name: Name of the original drug
        :return: Dictionary of potential substitutes
        """
        base_url = "https://api.fda.gov/drug/label.json"
        
        try:
            # Search for the drug to get initial information
            response = requests.get(base_url, params={
                'search': f'openfda.generic_name:"{drug_name}"',
                'limit': 10
            })
            
            response.raise_for_status()
            data = response.json()
            
            substitutes = []
            
            # Extract potential substitutes from drug labels
            for result in data.get('results', []):
                # Look for substitution-related information in the label
                substance_names = result.get('openfda', {}).get('substance_name', [])
                brand_names = result.get('openfda', {}).get('brand_name', [])
                
                substitutes.extend([
                    {
                        'substance_name': name,
                        'brand_names': brand_names
                    } for name in substance_names
                ])
            
            return {
                'original_drug': drug_name,
                'potential_substitutes': substitutes
            }
        
        except requests.RequestException as e:
            return {"error": f"API request failed: {str(e)}"}
    
    def substitute_drug(self, drug_name="metformin"):
        """
        Find drug substitutes and update Firebase
        
        :param drug_name: Name of the drug to find substitutes for
        :return: Drug substitution response
        """
        # Get drug substitution information
        response = self.open_fda_drug_substitution(drug_name)

        # Update Firebase 
        try:
            # Using Firebase library for real-time database update
            self.firebase.put(self.firebase_path, 'response', response)
        except Exception as e:
            print(f"Firebase update error: {str(e)}")
        
        return response