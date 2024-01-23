import requests
import json

url = "http://localhost/ask"

payload = json.dumps({
  "question": "Q: What are the names of the days of the week?"
})
headers = {
  'Content-Type': 'application/json'
}

response = requests.post(url, headers=headers, data=payload)

print(response.text)