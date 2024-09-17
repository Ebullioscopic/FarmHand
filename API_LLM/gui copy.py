import streamlit as st
from api import llama_api

# Language mapping
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
    "Marathi (Bengali script)": "mr",
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

# Streamlit app configuration
st.set_page_config(page_title="🦙💬Chatbot")

# Sidebar for language selection
with st.sidebar:    
    # Dropdown to select the source language
    source_language = st.selectbox(
        'Select Source Language', 
        options=list(language_map.keys()), 
        index=list(language_map.keys()).index("Tamil")
    )

# Store LLM generated responses
if "messages" not in st.session_state.keys():
    st.session_state.messages = [{"role": "assistant", "content": "How may I assist you today?"}]

# Display or clear chat messages
for message in st.session_state.messages:
    with st.chat_message(message["role"]):
        st.write(message["content"])

def clear_chat_history():
    st.session_state.messages = [{"role": "assistant", "content": "How may I assist you today?"}]
st.sidebar.button('Clear Chat History', on_click=clear_chat_history)

# Function for generating LLaMA2 response
def generate_llama2_response(prompt_input):
    language_code = language_map[source_language]
    response = llama_api(prompt_input, language_code)
    return response

# User-provided prompt
if prompt := st.chat_input():
    st.session_state.messages.append({"role": "user", "content": prompt})
    with st.chat_message("user"):
        st.write(prompt)

# Generate a new response if last message is not from assistant
if st.session_state.messages[-1]["role"] != "assistant":
    with st.chat_message("assistant"):
        with st.spinner("Thinking..."):
            response = generate_llama2_response(prompt)
            placeholder = st.empty()
            full_response = ''
            for item in response:
                full_response += item
                placeholder.markdown(full_response)
            placeholder.markdown(full_response)
    message = {"role": "assistant", "content": full_response}
    st.session_state.messages.append(message)
