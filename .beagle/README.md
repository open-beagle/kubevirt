# kubevirt

<https://github.com/kubevirt/kubevirt>

```bash
git remote add upstream git@github.com:kubevirt/kubevirt.git

git fetch upstream

git merge v1.3.1
```

## images

```bash
docker pull quay.io/kubevirt/virt-operator:v1.3.1 && \
docker tag quay.io/kubevirt/virt-operator:v1.3.1 registry.cn-qingdao.aliyuncs.com/wod/kubevirt-operator:v1.3.1 && \
docker push registry.cn-qingdao.aliyuncs.com/wod/kubevirt-operator:v1.3.1

docker pull quay.io/kubevirt/virt-api:v1.3.1 && \
docker tag quay.io/kubevirt/virt-api:v1.3.1 registry.cn-qingdao.aliyuncs.com/wod/kubevirt-api:v1.3.1 && \
docker push registry.cn-qingdao.aliyuncs.com/wod/kubevirt-api:v1.3.1

docker pull quay.io/kubevirt/virt-controller:v1.3.1 && \
docker tag quay.io/kubevirt/virt-controller:v1.3.1 registry.cn-qingdao.aliyuncs.com/wod/kubevirt-controller:v1.3.1 && \
docker push registry.cn-qingdao.aliyuncs.com/wod/kubevirt-controller:v1.3.1

docker pull quay.io/kubevirt/virt-handler:v1.3.1 && \
docker tag quay.io/kubevirt/virt-handler:v1.3.1 registry.cn-qingdao.aliyuncs.com/wod/kubevirt-handler:v1.3.1 && \
docker push registry.cn-qingdao.aliyuncs.com/wod/kubevirt-handler:v1.3.1

docker pull quay.io/kubevirt/virt-launcher:v1.3.1 && \
docker tag quay.io/kubevirt/virt-launcher:v1.3.1 registry.cn-qingdao.aliyuncs.com/wod/kubevirt-launcher:v1.3.1 && \
docker push registry.cn-qingdao.aliyuncs.com/wod/kubevirt-launcher:v1.3.1
```

## install

```bash
kubectl create -f /etc/kubernetes/addons/kubevirt/kubevirt-operator.yaml

kubectl create -f /etc/kubernetes/addons/kubevirt/kubevirt-cr.yaml

kubectl label nodes <node-name> kubevirt.io/gpunode=true
```
