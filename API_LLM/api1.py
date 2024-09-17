import pandas as pd
data = pd.read_csv("vegetable_prices_with_farmers.csv")

from langchain_community.llms import Ollama
llm = Ollama(model="llama3")



from pandasai import SmartDataframe
df = SmartDataframe(data, config={"llm": llm})


print(df.chat('price of tomato in potheri?'))