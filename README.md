# k8s-ci-cd-pipeline

This project was part of the kubernetes challenge of Digital Ocean. Therefore I created a small pipeline to build and deploy a simple golang application which provides an endpoint and returns "Hello World". I was inspired by the following article. https://medium.com/dzerolabs/using-tekton-and-argocd-to-set-up-a-kubernetes-native-build-release-pipeline-cf4f4d9972b0

The golang application can be found here https://github.com/devandi/simple-web-app.

## Goal
The goal was to create a simple app and deploy it in a kubernetes cluster. This process should be as automatic as possible. So one pushes to the github repository which triggers the pipeline. In the pipeline the app is built and a container-image is created and uploaded to a registry. Afterwards the deploy process is started and the app is rolled out in the cluster. 
A side goal was to have as much as possible definied "as code". 

## Components
Github for storing the code and the yaml-files. 
Everything is running in a managed kubernetes cluster of Digital Ocean. 
Terraform was used to create the infrastructure like the cluster and the container registry. The files can be found in the folder "terraform". 
Tekton is used for building and creating the image registry. 
Kaniko is used to build the container image.
ArgoCD is used for deploying the app in a kubernetes cluster.
Kustomize was used for handling the yaml files

### Terraform
With Terraform the infrastructure was created at Digital Ocean. A managed kubernetes cluster and a container registry was created. 

### Tekton
The project was started with creating the Tekton pipeline. The pipeline has just a few steps. It gets triggered by a github webhook after a push to the repository. In the first step the app is built and a container-image is created with Kaniko. This image is uploaded to a container registry. 
Tekton can be installed with running the Kustomize file in the tekton -> setup folder. The pipeline for the app can be found in the app folders. 

### ArgoCD
ArgoCD was used for deploying the app to the cluster. ArgoCD can be installed with the Kustomize file in the argocd setup folder. The app specific files are in the app folder. In ArgoCD the app repository was setup. The last step of the Tekton pipeline calls Sync in ArgoCD. Then ArgoCD checks if it has to deploy a new version to the cluster or not (see here the open issue at the end of the readme)


## Issues
There is a problem which I was not solving yet. At the moment one has to maintain the version-numbers in the app-repository in the deployment.yaml and in the Tekton pipeline manually. Originally I wanted to automatize this too, but this is still work in progress. 


## Ressources
* Digital Ocean - https://digitalocean.com
* Tekton - https://tekton.dev
* ArgoCD - https://argo-cd.readthedocs.io/en/stable/
* Kaniko - https://github.com/GoogleContainerTools/kaniko
* https://medium.com/dzerolabs/using-tekton-and-argocd-to-set-up-a-kubernetes-native-build-release-pipeline-cf4f4d9972b0