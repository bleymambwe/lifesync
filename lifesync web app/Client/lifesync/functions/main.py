import firebase_admin
from firebase_admin import credentials, db
from firebase_admin import functions

# Initialize the Firebase Admin SDK
cred = credentials.ApplicationDefault()
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://lifesync-ai-default-rtdb.firebaseio.com/'
})

# Define Cloud Function to listen to database changes
@functions.database.ref('/user/post/{postId}')
def on_post_created(event, context):
    """Triggered when a new post is added to the 'user/post' node."""
    # Fetch the latest post data from the snapshot
    post_data = event.data
    if post_data:
        # Get the latest post content
        post_text = post_data.get('text', '')
        timestamp = post_data.get('time', '')
        
        # Modify the post text as needed
        modified_text = f"Modified: {post_text}"

        # Example modified response data
        response_data = {
            'text': modified_text,  # The modified text
            'original_text': post_text,  # Keep the original text for reference
            'time': timestamp
        }

        # Push the modified response to 'user/response' node
        response_ref = db.reference('/user/response')
        response_ref.push(response_data)
        print(f"Response added to /user/response: {response_data}")

    return 'ok'  # Required for Firebase function to complete
