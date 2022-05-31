
<!-- markdownlint-disable -->
# Confluent GitOps Demo
<!-- markdownlint-restore -->

[![README Header][readme_header_img]][readme_header_link]

<!--




  ** DO NOT EDIT THIS FILE
  **
  ** This file was automatically generated by the `build-harness`.
  ** 1) Make all changes to `README.yaml`
  ** 2) Run `make init` (you only need to do this once)
  ** 3) Run`make readme` to rebuild this file.
  **
  ** (We maintain HUNDREDS of open source projects. This is how we maintain our sanity.)
  **





-->
Fully automated Confluent Platform Demo which deploys Kafka in multiple namespaces and uses the TF Controller with Confluent Terraform Provider to provision Confluent Cloud resources.

---






## Usage


The Toolkit components consist of Source Controller, Kustomize Controller, Helm Controller, Notification Controller and the Image Automation Controllers.
```
├── flux-system
│   ├── gotk-components.yaml
│   ├── gotk-sync.yaml
│   └── kustomization.yaml
├── kustomize
│   ├── base
│   │   ├── confluent
│   │   │   ├── connect
│   │   │   │   ├── kafka-connect.yaml
│   │   │   │   └── kustomization.yaml
│   │   │   ├── control-centre
│   │   │   │   ├── control-centre.yaml
│   │   │   │   └── kustomization.yaml
│   │   │   ├── kafka.yaml
│   │   │   ├── ksqldb
│   │   │   │   ├── ksqldb.yaml
│   │   │   │   └── kustomization.yaml
│   │   │   ├── kustomization.yaml
│   │   │   ├── schmea-registry
│   │   │   │   ├── kustomization.yaml
│   │   │   │   └── schema-registry.yaml
│   │   │   ├── secrets
│   │   │   │   ├── ca-pair-sslcerts.yaml
│   │   │   │   ├── kustomization.yaml
│   │   │   │   └── mds-public.yaml
│   │   │   └── zookeeper.yaml
│   │   └── kustomization.yaml
│   ├── environments
│   │   ├── kustomization.yaml
│   │   ├── production
│   │   │   ├── kustomization.yaml
│   │   │   └── namespace.yaml
│   │   └── sandbox
│   │       ├── kafka.yaml
│   │       ├── kustomization.yaml
│   │       ├── namespace.yaml
│   │       └── zookeeper.yaml
│   ├── operator
│   │   ├── confluent-operator-helm-release-confluent.yaml
│   │   ├── kustomization.yaml
│   │   └── namespace.yaml
│   ├── terraform
│   │   ├── confluent-cloud.yaml
│   │   ├── kustomization.yaml
│   │   └── namespace.yaml
│   └── tf-controller
│       ├── kustomization.yaml
│       └── terraform-controller-helm-release.yaml
```




## Examples

### Deployment Process
#### 1. Create your Kubernetes cluster
We will be using MiniKube, but any remote cluster will work. Create the cluster using: 
* Run `minikube start --cpus=6 --memory=20019 --kubernetes-version=v1.21.0`

#### 2. Deploy the GitOps toolkit
Toolkit CRDs and components are deployed using: 
* Navigate to `./flux-system`
* Run `kubectl apply -f gotk-components.yaml`

#### 3. Deploy Flux Sync
* Navigate to `./flux-system`
* run `kubectl apply -f gotk-sync.yaml`
This next step will tell Flux what repository to monitor, and, within that repository, what kustomization files to start with. The first Kustomize resource that Flux will look for to is located at `./kustomize/operator`.  This will install the confluent-for-kubernetes Helm chart which will monitor all namespaces for Confluent CRDs.   
After a successful health check of the operator (which will run as a pod), Flux will then proceed to deploy the following Kustomizations:
  * Production environment located at  `./kustomize/environments/production`
  * Sandbox environment located at  `./kustomize/environments/sandbox`
  * TF Controller for reconciling Terraform resources in the GitOps way located at `./kustomize/environments/tf-controller`
  * Auto Apply Terraform using the variables located at `./kustomize/environments/terraform`
  
#### 4. Let Flux work its magic
Now that we have flux monitoring the forked Git repository, let's demonstrate the GitOps behaviour!  If everything has deployed successfully, you should see a healthy confluent stack looking like this:
  ```console
  │ NAME                                          PF   READY      RESTARTS STATUS      IP              NODE         AGE        │
  │ confluent-operator-global-7ffc5b469d-knmfj    ●    1/1               0 Running     172.17.0.7      minikube     21m        │
  │ connect-0                                     ●    1/1               0 Running     172.17.0.17     minikube     9m31s      │
  │ controlcenter-0                               ●    1/1               1 Running     172.17.0.11     minikube     21m        │
  │ kafka-0                                       ●    1/1               3 Running     172.17.0.8      minikube     21m        │
  │ kafka-1                                       ●    1/1               3 Running     172.17.0.10     minikube     21m        │
  │ kafka-2                                       ●    1/1               3 Running     172.17.0.9      minikube     21m        │
  │ ksqldb-0                                      ●    1/1               1 Running     172.17.0.12     minikube     21m        │
  │ schemaregistry-0                              ●    1/1               1 Running     172.17.0.14     minikube     21m        │
  │ zookeeper-0                                   ●    1/1               0 Running     172.17.0.15     minikube     21m        │
  │ zookeeper-1                                   ●    1/1               0 Running     172.17.0.16     minikube     21m        │
  │ zookeeper-2                                   ●    1/1               0 Running     172.17.0.13     minikube     21m        │
  │
  ```





## Related Projects

Check out these related projects.

- [Terraform GitOps Example](https://github.com/osodevops/terraform-gitops-example) - A Terraform GitOps workflow showcasing how to use the TF-Controller to run your Terraform via GitOps
- [Kafka GitOps Example](https://github.com/osodevops/kafka-gitops-examples) - A Kafka / Confluent GitOps workflow example for multi-env deployments with Flux, Kustomize, Helm and Confluent Operator
- [Confluent Platform on Azure](https://github.com/osodevops/terraform-azure-confluent-platform) - Terraform Module for deploying best practice HA Confluent Platform on Azure



## Need some help

File a GitHub [issue](https://github.com/osodevops/confluent-gitops-demo/issues), send us an [email][email] or [tweet us][twitter].

## The legals

Copyright © 2017-2022 [OSO](https://oso.sh) | See [LICENCE](LICENSE) for full details.

[<img src="https://oso-public-resources.s3.eu-west-1.amazonaws.com/oso-logo-green.png" alt="OSO who we are" width="250"/>](https://oso.sh/who-we-are/)

## Who we are

We at [OSO][website] help teams to adopt emerging technologies and solutions to boost their competitiveness, operational excellence and introduce meaningful innovations that drive real business growth. Our developer-first culture, combined with our cross-industry experience and battle-tested delivery methods allow us to implement the most impactful solutions for your business.

Looking for support applying emerging technologies in your business? We’d love to hear from you, get in touch by [email][email]

Start adopting new technologies by checking out [our other projects][github], [follow us on twitter][twitter], [join our team of leaders and challengers][careers], or [contact us][contact] to find the right technology to support your business.[![Beacon][beacon]][website]

  [logo]: https://oso-public-resources.s3.eu-west-1.amazonaws.com/oso-logo-green.png
  [website]: https://oso.sh?utm_source=github&utm_medium=readme&utm_campaign=osodevops/confluent-gitops-demo&utm_content=website
  [github]: https://github.com/osodevops?utm_source=github&utm_medium=readme&utm_campaign=osodevops/confluent-gitops-demo&utm_content=github
  [careers]: https://oso.sh/careers/?utm_source=github&utm_medium=readme&utm_campaign=osodevops/confluent-gitops-demo&utm_content=careers
  [contact]: https://oso.sh/contact/?utm_source=github&utm_medium=readme&utm_campaign=osodevops/confluent-gitops-demo&utm_content=contact
  [linkedin]: https://www.linkedin.com/company/oso-devops?utm_source=github&utm_medium=readme&utm_campaign=osodevops/confluent-gitops-demo&utm_content=linkedin
  [twitter]: https://twitter.com/osodevops?utm_source=github&utm_medium=readme&utm_campaign=osodevops/confluent-gitops-demo&utm_content=twitter
  [email]: mailto:enquiries@oso.sh?utm_source=github&utm_medium=readme&utm_campaign=osodevops/confluent-gitops-demo&utm_content=email
  [readme_header_img]: https://oso-public-resources.s3.eu-west-1.amazonaws.com/oso-animation.gif
  [readme_header_link]: https://oso.sh/what-we-do/?utm_source=github&utm_medium=readme&utm_campaign=osodevops/confluent-gitops-demo&utm_content=readme_header_link
  [beacon]: https://github-analyics.ew.r.appspot.com/G-WV0Q3HYW08/osodevops/confluent-gitops-demo?pixel&cs=github&cm=readme&an=confluent-gitops-demo
