
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

## 下载项目从源码编译

---

## 下载项目编译并部署 webhook-helm
make # 编译bin-》制作镜像-》部署k8s yaml -》启动应用

## 部署k8s yaml 
请参考 template-out-mini1 目录

## helm仓库配置
helm package webhook-helm-mini
helm repo index .
