# ChatGPTAPIClone

## Overview
This is a dockerized python FastAPI that uses the Llama2 large language model to answer prompts similarly to ChatGPT. 

## How to Run This Myself
1. You need to download LLAMA 2 Model at https://huggingface.co/TheBloke/Llama-2-7B-Chat-GGML/blob/main/llama-2-7b-chat.ggmlv3.q8_0.bin and save it to this repository.

2. You need to run ```docker build -t container-name .``` to build the image

3. To run the api locally type ```docker run -d -p 80:80 container-name```

4. Here are some example ways to call the api:

### curl Request:
```
curl --location 'localhost/ask' \
--header 'Content-Type: application/json' \
--data '{
    "question": "Q: What are the names of the days of the week?"
}'
```

### JavaScript Request
```
var myHeaders = new Headers();
myHeaders.append("Content-Type", "application/json");

var raw = JSON.stringify({
  "question": "Q: What are the names of the days of the week?"
});

var requestOptions = {
  method: 'POST',
  headers: myHeaders,
  body: raw,
  redirect: 'follow'
};

fetch("localhost/ask", requestOptions)
  .then(response => response.text())
  .then(result => console.log(result))
  .catch(error => console.log('error', error));
```

### Python Request
```
import requests
import json

url = "localhost/ask"

payload = json.dumps({
  "question": "Q: What are the names of the days of the week?"
})
headers = {
  'Content-Type': 'application/json'
}

response = requests.request("POST", url, headers=headers, data=payload)

print(response.text)
```

### Response
```
{
    "answer": "\nA: The names of the days of the week, in order, are:\n\n1. Sunday\n2. Monday\n3. Tuesday\n4. Wednesday\n5. Thursday\n6. Friday\n7. Saturday"
}
```