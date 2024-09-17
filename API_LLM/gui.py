import chainlit as cl
from api import llama_api


language_map = {
    "Assamese (Bengali script)": "as",
    "Awadhi (Devanagari script)": "hi",
    "Bangla": "bn",
    "Boro (Devanagari script)": "brx",
    "Dogri (Devanagari script)": "doi",
    "English": "en",
    "Konkani (Devanagari script)": "gom",
    "Gujarati": "gu",
    "Hindi": "hi",
    "Kannada": "kn",
    "Kashmiri (Arabic script)": "ks",
    "Maithili (Devanagari script)": "mai",
    "Malayalam": "ml",
    "Manipuri": "mni",
    "marathi (Bengali script)": "mr",
    "Nepali (Devanagari script)": "ne",
    "Odia": "or",
    "Punjabi (Gurmukhi script)": "pa",
    "Sanskrit": "sa",
    "Santali (Ol Chiki script)": "sat",
    "Sindhi (Arabic script)": "sd",
    "Tamil": "ta",
    "Telugu": "te",
    "Urdu": "ur",
}

# Get the source language from user input
source_language = "ta"

@cl.on_message
async def on_message(message: cl.Message):
    # Extract the content of the message
    query = message.content
    
    # Process the query with the provided source language
    response = llama_api(query, source_language)
    
    # Send the response back
    await cl.Message(content=response).send()
