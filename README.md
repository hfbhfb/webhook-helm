
## 部署-步骤1：直接使用helm仓库部署测试
helm repo add webhook-helm https://hfbhfb.github.io/webhook-helm
helm search repo webhook-helm -l
helm pull webhook-helm/webhook-helm-mini  --untar --version 0.1.0

#### 部署-步骤2：
helmAppName=mini1
Space=webhookmini
kubectl create ns ${Space}
touch values.yaml
helm install webhook-helm-mini/ --namespace  ${Space} --values ./values.yaml --name-template ${helmAppName} 

#### 部署-步骤3：测试
kubectl delete ns ns12; kubectl create ns ns12; kubectl label namespace ns12 webhook-mini=enabled; # 准备命名空间
kubectl create -n ns12 deployment dep1 --image=nginx --replicas=1 # 期望失败，因为没有相应的label
#### kubectl apply -f dep2.yaml #项目下这个yaml是可成功部署的

#### 部署-步骤4：清理数据
helm uninstall --namespace  ${Space} ${helmAppName} 




---

## 目录及文件说明

1. 根目录下
>- Makefile # 组织依赖关系： 编译bin-》制作镜像-》部署k8s yaml -》启动应用
>- dep2.yaml # 测试验证用yaml

2. webhook-helm-mini目录
>- main.go # 代码入口和 webhook validate 处理逻辑
>- mutate.go # webhook mutate 处理逻辑
>- Makefile # make文件，编译入口
>- Dockerfile # 镜像制作

3. template-out-mini1目录 # helm template输出的文件，可以看到真正部署到的内容

4. code-webhook-mini目录
>- main.go # 代码入口和 webhook validate 处理逻辑
>- mutate.go # webhook mutate 处理逻辑
>- Makefile # make文件，编译入口
>- Dockerfile # 镜像制作


---
