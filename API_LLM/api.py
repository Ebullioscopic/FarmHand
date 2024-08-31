import requests

# Language mapping dictionary
language_map = {
    "Assamese (Bengali script)": "as",
    "Awadhi (Devanagari script)": "hi",
    "Bengali": "bn",
    "Bhojpuri (Devanagari script)": "hi",
    "Bodo (Devanagari script)": "hi",
    "Dogri (Devanagari script)": "hi",
    "English": "en",
    "Konkani (Devanagari script)": "kK",
    "Gujarati": "gu",
    "Hindi": "hi",
    "Chhattisgarhi (Devanagari script)": "hi",
    "Kannada": "kn",
    "Kashmiri (Arabic script)": "ur",
    "Kashmiri (Devanagari script)": "hi",
    "Khasi (Latin script)": "en",
    "Mizo (Latin script)": "en",
    "Magahi (Devanagari script)": "hi",
    "Maithili (Devanagari script)": "hi",
    "Malayalam": "ml",
    "Marathi": "mr",
    "Meitei (Bengali script)": "bn",
    "Meitei (Meetei Mayek script)": "hi",
    "Nepali (Devanagari script)": "ne",
    "Odia": "or",
    "Punjabi (Gurmukhi script)": "pa",
    "Sanskrit": "hi",
    "Santali (Ol Chiki script)": "or",
    "Sindhi (Arabic script)": "ur",
    "Sindhi (Devanagari script)": "hi",
    "Tamil": "ta",
    "Telugu": "te",
    "Urdu": "ur",
}

def get_language_code(language_code):
    reversed_map = {v: k for k, v in language_map.items()}
    return reversed_map.get(language_code.lower(), None)

# Input from the user
source_language_code = input("Enter the source language code (e.g., en): ").strip().lower()
target_language_code = input("Enter the target language code (e.g., ta): ").strip().lower()
text_to_translate = input("Enter the text to translate: ")

# Validate language codes
if not get_language_code(source_language_code) or not get_language_code(target_language_code):
    print("Invalid language code selection.")
else:
    # Define the API endpoint
    url = "https://demo-api.models.ai4bharat.org/inference/translation/v2"

    # Define the payload
    payload = {
        "controlConfig": {
            "dataTracking": True
        },
        "input": [
            {
                "source": text_to_translate
            }
        ],
        "config": {
            "serviceId": "",
            "language": {
                "sourceLanguage": source_language_code,
                "targetLanguage": target_language_code,
                "targetScriptCode": None,
                "sourceScriptCode": None
            }
        }
    }

    # Send the POST request
    response = requests.post(url, json=payload)

    # Check if the request was successful
    if response.status_code == 200:
        result = response.json()
        print("Translation Output:", result.get("output", [{}])[0].get("target", "No output found"))
    else:
        print(f"Failed to get a response. Status code: {response.status_code}")
