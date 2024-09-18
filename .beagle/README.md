# kubevirt

<https://github.com/kubevirt/kubevirt>

```bash
git remote add upstream git@github.com:kubevirt/kubevirt.git

git fetch upstream

git merge v1.3.1
```

## build

```bash
docker run -it --rm \
-v $PWD/:/go/src/github.com/kubevirt/kubevirt \
-w /go/src/github.com/kubevirt/kubevirt \
registry.cn-qingdao.aliyuncs.com/wod/golang:1.22-alpine \
bash .beagle/build.sh

docker pull quay.io/kubevirt/builder:2408161422-1f8c489011 && \
docker tag quay.io/kubevirt/builder:2408161422-1f8c489011 registry.cn-qingdao.aliyuncs.com/wod/kubevirt-operator:builder-2408161422-1f8c489011 && \
docker push registry.cn-qingdao.aliyuncs.com/wod/kubevirt-operator:builder-2408161422-1f8c489011

export KUBEVIRT_BUILDER_IMAGE=registry.cn-qingdao.aliyuncs.com/wod/kubevirt-operator:builder-2408161422-1f8c489011
make bazel-build
```

## images

```bash
docker pull quay.io/kubevirt/virt-operator:v1.3.1 && \
docker tag quay.io/kubevirt/virt-operator:v1.3.1 registry.cn-qingdao.aliyuncs.com/wod/kubevirt-operator:1.3.1 && \
docker push registry.cn-qingdao.aliyuncs.com/wod/kubevirt-operator:1.3.1

docker pull quay.io/kubevirt/virt-api:v1.3.1 && \
docker tag quay.io/kubevirt/virt-api:v1.3.1 registry.cn-qingdao.aliyuncs.com/wod/kubevirt-api:1.3.1 && \
docker push registry.cn-qingdao.aliyuncs.com/wod/kubevirt-api:1.3.1

docker pull quay.io/kubevirt/virt-controller:v1.3.1 && \
docker tag quay.io/kubevirt/virt-controller:v1.3.1 registry.cn-qingdao.aliyuncs.com/wod/kubevirt-controller:1.3.1 && \
docker push registry.cn-qingdao.aliyuncs.com/wod/kubevirt-controller:1.3.1

docker pull quay.io/kubevirt/virt-handler:v1.3.1 && \
docker tag quay.io/kubevirt/virt-handler:v1.3.1 registry.cn-qingdao.aliyuncs.com/wod/kubevirt-handler:1.3.1 && \
docker push registry.cn-qingdao.aliyuncs.com/wod/kubevirt-handler:1.3.1

docker pull quay.io/kubevirt/virt-launcher:v1.3.1 && \
docker tag quay.io/kubevirt/virt-launcher:v1.3.1 registry.cn-qingdao.aliyuncs.com/wod/kubevirt-launcher:1.3.1 && \
docker push registry.cn-qingdao.aliyuncs.com/wod/kubevirt-launcher:1.3.1
```

## install

```bash
kubectl create -f /etc/kubernetes/addons/kubevirt/kubevirt-operator.yaml

kubectl create -f /etc/kubernetes/addons/kubevirt/kubevirt-cr.yaml

kubectl label nodes <node-name> kubevirt.io/gpunode=true
```
