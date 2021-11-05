This is the first draft of deploying Jambonz on Kubernetes (K8S). The K8S manifests are built based on the Docker compose file in the same repository.

# Notes

- The Ingresses are set up to work with [Traefik v1.7](https://doc.traefik.io/traefik/v1.7/). Please adapt it to work with the Ingress Controller of your cluster

# Manual steps

- Setup MySQL databases and tables
- Setup public DNS for `webapp` and `api-server`. It looks like that `webapp` connects to `api-server` in the front-end, so public DNS for `api-server` is needed.

# Deployment

The current deployment uses Kustomize:

```bash
kubectl apply -k .
```

# TODO

- Use Secret to store MySQL password
- Setup MySQL databases and tables using sidecar