import google.generativeai as genai
import os

genai.configure(api_key=os.getenv("GEMINI_API_KEY"))

myfile = genai.upload_file(r"/Users/admin63/Downloads/hari.jpeg")
print(f"{myfile=}")

model = genai.GenerativeModel("gemini-1.5-flash")
result = model.generate_content(
    [myfile, "\n\n", "Will this guy get a sanskari girl?"]
)
print(f"{result.text=}")