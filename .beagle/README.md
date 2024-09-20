# kubevirt

<https://github.com/kubevirt/kubevirt>

```bash
git remote add upstream git@github.com:kubevirt/kubevirt.git

git fetch upstream

git merge v1.3.1
```

## build

```bash
# 清理缓存
rm -rf _out/dist

# amd64
docker run -it --rm \
-v $PWD/:/go/src/github.com/kubevirt/kubevirt \
-w /go/src/github.com/kubevirt/kubevirt \
-e BUILD_VERSION=v1.3.1 \
-e BUILD_ARCH=amd64 \
registry.cn-qingdao.aliyuncs.com/wod/golang:1.22-alpine-amd64 \
bash .beagle/build.sh

# arm64
docker run -it --rm \
-v $PWD/:/go/src/github.com/kubevirt/kubevirt \
-w /go/src/github.com/kubevirt/kubevirt \
-e BUILD_VERSION=v1.3.1 \
-e BUILD_ARCH=arm64 \
registry.cn-qingdao.aliyuncs.com/wod/golang:1.22-alpine-arm64 \
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

## cache

```bash
# 构建缓存-->推送缓存至服务器
docker run --rm \
  -e PLUGIN_REBUILD=true \
  -e PLUGIN_ENDPOINT=$PLUGIN_ENDPOINT \
  -e PLUGIN_ACCESS_KEY=$PLUGIN_ACCESS_KEY \
  -e PLUGIN_SECRET_KEY=$PLUGIN_SECRET_KEY \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="kubevirt" \
  -e PLUGIN_MOUNT=".git,_out/dist" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0

# 读取缓存-->将缓存从服务器拉取到本地
docker run --rm \
  -e PLUGIN_RESTORE=true \
  -e PLUGIN_ENDPOINT=$PLUGIN_ENDPOINT \
  -e PLUGIN_ACCESS_KEY=$PLUGIN_ACCESS_KEY \
  -e PLUGIN_SECRET_KEY=$PLUGIN_SECRET_KEY \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="kubevirt" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0
```
