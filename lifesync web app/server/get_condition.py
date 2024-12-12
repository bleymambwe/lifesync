from firebase_admin import db

def get_user_details():
    print('geting user details for call')
    try:
        # Reference to the specific path in the Firebase Realtime Database
        user_details_ref = db.reference('/user/details/user_details')
        
        # Retrieve data from the specified path
        user_data = user_details_ref.get()
        print('user data',user_data)

        if user_data:
            # Extract the phone_number and condition
            phone_number = user_data.get('contact')
            condition = user_data.get('condition')
            print('retrieve phone and condition nicely',condition)
            return phone_number, condition
        else:
            print("No data found at the specified path")
            return None, None

    except Exception as e:
        print(f"Error retrieving data: {e}")
        
        return None, None