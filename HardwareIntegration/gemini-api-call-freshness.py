import google.generativeai as genai
import os
import json

API_KEY = "AIzaSyBsaIoUvd6GWDkD2uK57-5NfKbOFYcrofo"  
genai.configure(api_key=API_KEY)

def process_image_and_prompt(image_path: str, prompt: str):
    try:
        # Upload the image file
        myfile = genai.upload_file(image_path)
        print(f"Uploaded file: {myfile}")

        # Initialize the Gemini model
        model = genai.GenerativeModel("gemini-1.5-flash")

        # Use the model to generate content based on the image and prompt
        result = model.generate_content([myfile, "\n\n", prompt])

        # Format the result as JSON
        return json.dumps({"result": result.text if result.text else ""})

    except Exception as e:
        # Handle exceptions and return an empty JSON object in case of errors
        print(f"An error occurred: {e}")
        return json.dumps({})

# Example usage
image_path = r"/Users/internalis/Downloads/images.jpeg"
prompt = "What is its expected shelflife?"
output = process_image_and_prompt(image_path, prompt)
print(f"Output: {output}")



#API_KEY = "AIzaSyBsaIoUvd6GWDkD2uK57-5NfKbOFYcrofo"  
#genai.configure(api_key=API_KEY)

#genai.configure(api_key=os.getenv("GEMINI_API_KEY"))