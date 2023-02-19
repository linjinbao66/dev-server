# dev-server
A common image for developers, with a lot of tools been pre-installed.

# build image

```bash

docker build -t my-image:my-tag .

```

# run image

```bash

docker run -d my-image:my-tag 
kubectl run my-dev --image my-image:my-tag

```
