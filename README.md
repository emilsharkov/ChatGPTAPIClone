# ChatGPTAPIClone

## Overview
The goal of this project is to create a scalable and fault tolerant API that can answer questions like ChatGPT with the help of the Llama 2.0 large language model. To approach this, I created a Python FastAPI that uses the llama-cpp-python library to communicate with the LLM. To scale this, I containerized this application into a docker image and decided to use kubernetes to help with horizontal scaling and container orchestration. I decided to use Terraform to deploy my cluser to AWS EKS.

## How to Run This Myself
### Prerequisites:
- LLAMA 2.0 Model at https://huggingface.co/TheBloke/Llama-2-7B-Chat-GGML/blob/main/llama-2-7b-chat.ggmlv3.q8_0.bin and save it to the ```/app``` folder
- docker
- kubectl
- aws cli
- terraform

1. Type ```cd /terraform``` to get into the terraform folder
2. Type ```terraform init``` to initialize the terraform project
3. Type ```terraform plan``` to check which resources will be generated (eks cluster and nodes for the cluster)
4. Type ```terraform apply``` to create the resources
5. Once the resources are created type ```aws eks list-clusters``` and you should see 'my-cluster' in the list
6. Type ```aws eks update-kubeconfig --region us-west-2 --name my-cluster``` to change the kubectl context to your cluster
7. Type ```kubectl get nodes``` to check on the status of the newly created node resources
8. Type ```kubectl create ns fastapi-app``` to create the namespace for your application in kubernetes
9. Type ```cd ../k8s``` to switch folders to get access to the manifests
10. Type ```kubectl apply -f deployment.yaml``` to create the deployment
11. ```kubectl get deployments -n fastapi-app``` to check on the status of the deployment
12. ```kubectl apply -f service.yaml``` to create the service (your load balancer)
13. ```kubectl get services -n fastapi-app``` to check on the status of the service and to get the URL of the load balancer
14. Now you can use the URL from the previous step to call the API!
15. ```terraform destroy``` to delete all resources from AWS (it is very costly)

## How to call the API:

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
