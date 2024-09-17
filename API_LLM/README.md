## Files

- **gui-streamlit.py**: This file contains the Streamlit GUI code with a sidebar for language selection. You can interact with the chatbot through this interface with language control.
  
- **gui.py**: This file contains the Chainlit GUI code, where the language has to be hardcoded each time before running.

## How to Run

### Running the Streamlit GUI

Start the Streamlit app by running the following command:

```bash
streamlit run gui-streamlit.py
```

#### How the Streamlit GUI works:

- The sidebar allows you to choose a source language from a predefined list.
- The selected language will be used to process your input and translate it into English for the chatbot's response.
- The chatbot's reply will be translated back into the selected language and displayed in the chat window.

### Running the Chainlit GUI

Before running the Chainlit GUI, you need to modify the source language:

1. Open `gui.py`.
2. Hardcode the source language in the `llama_api()` function.

### Interaction Flow

1. You input text in the selected source language.
2. The text is translated to English using the AI4Bharat API.
3. The translated text is processed by the chatbot (Ollama API).
4. The chatbot's response is translated back to the original language and shown to you.
