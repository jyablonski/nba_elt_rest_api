# EKS
![image](https://github.com/jyablonski/nba_elt_rest_api/assets/16946556/54299b0e-f971-4cc0-a8ad-6a9450c819c5)
![image](https://github.com/jyablonski/nba_elt_rest_api/assets/16946556/f9fdc20c-5a45-4fd9-baa7-366be8817b4d)

Got a working POC working after deploying an EKS Cluster via Terraform.  Just have to setup kubectl by running that `aws eks update` command and point it at the new EKS Cluster while having valid credentials active.

Couple things:
- The App was hosted on HTTP with the port 8080 crap hanging out at the end http://a837a831b7ac848a3b139bcb9a84f26d-1964314560.us-east-1.elb.amazonaws.com:8080
- Creds were stored in `secrets.yaml` by running `echo -n "prod" | base64` on the Secrets.  I removed this prior to committing to version control.
- The actual App worked fine.  Every endpoint worked, login / JWT worked, bets page worked.  
- Secrets shouldn't be stored in their Base64 encoded values in version control.  Should use AWS Secrets Manager, but that looked like a bit of a lift to setup for a 1 time POC.
- Actual Networking is typically much more difficult than this.  My RDS Database is public and I didn't have to adjust any of the Node Group Security Groups to actually make it work.
- To Dos are probably get HTTPS working, get it served over a custom endpoint `https://eksapi.jyablonski.dev` or something, 
- My creds run out end of March 2024 so I won't be able to continue this until the next account

## EKS Commands
``` sh
aws eks update-kubeconfig --region us-east-1 --name jacobs-eks-cluster

kubectl get nodes

kubectl get pods

kubectl describe deployment rest-api-deployment

kubectl apply -f k8s/deployment.yaml

kubectl apply -f k8s/secrets.yaml

kubectl apply -f k8s/service.yaml

kubectl get services

# 2 ips returned because it's a load balancer in 2 AZs
nslookup a0a2b088ae4734daf9da2131bd65030a-1730599489.us-east-1.elb.amazonaws.com
nslookup a837a831b7ac848a3b139bcb9a84f26d-1964314560.us-east-1.elb.amazonaws.com

# 10.0.3.89:8080 endpoint returned
kubectl describe service nba-elt-rest-api-deployment

kubectl delete service nba-elt-rest-api-deployment

kubectl get pods
kubectl exec --stdin --tty rest-api-deployment-7c58458667-92wcv -- /bin/bash

kubectl get events

kubectl get pod --show-labels

kubectl logs rest-api-deployment-7c58458667-92wcv
```

## Kind

``` sh
export NAMESPACE=restapi

kind create cluster
kubectl create namespace restapi

kubectl apply -f k8s/deployment.yaml --namespace $NAMESPACE

kubectl apply -f k8s/secrets.yaml --namespace $NAMESPACE

kubectl apply -f k8s/service.yaml --namespace $NAMESPACE

kubectl apply -f k8s/deployment-hpa.yml --namespace $NAMESPACE

kind load docker-image nba_elt_rest_api_local:latest --name kind

docker exec -it 64328b37ce14 crictl images

kubectl port-forward rest-api-deployment-56f998677c-6987s 8080:8080 --namespace $NAMESPACE

kubectl logs rest-api-deployment-56f998677c-ppl9c --namespace $NAMESPACE

echo -n 'prod' | base64

kubectl get pods --namespace $NAMESPACE

# install kubernetes metrics api
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

kubectl describe hpa rest-api-deployment-hpa --namespace $NAMESPACE

# for this to work, have to --kubelet-insecure-tls to remove security

kubectl apply -f k8s/metrics-server-deployment.yaml

# to use secrets from secrets manager instead of base64 encoded bs, do this
helm repo add external-secrets https://charts.external-secrets.io
helm install external-secrets external-secrets/external-secrets
```

`secrets_store.yml`

``` yaml
apiVersion: external-secrets.io/v1beta1
kind: SecretStore
metadata:
  name: aws-secrets-manager
  namespace: restapi
spec:
  provider:
    aws:
      service: SecretsManager
      region: your-aws-region
      auth:
        secretRef:
          accessKeyIDSecretRef:
            name: aws-credentials
            key: aws_access_key_id
          secretAccessKeySecretRef:
            name: aws-credentials
            key: aws_secret_access_key

```

`secrets.yml`

``` yml
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: rest-api-secrets
  namespace: restapi
spec:
  refreshInterval: "1h"
  secretStoreRef:
    name: aws-secrets-manager
    kind: SecretStore
  target:
    name: rest-api-secrets
    creationPolicy: Owner
  data:
  - secretKey: RDS_HOST
    remoteRef:
      key: your-aws-secrets-manager-key
      property: RDS_HOST
  - secretKey: RDS_USER
    remoteRef:
      key: your-aws-secrets-manager-key
      property: RDS_USER

```

- this file pulls from secrets manager using the provided creds to give the secrets to the pods running your deployment