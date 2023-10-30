


# webhook-helm
make # 编译bin-》制作镜像-》部署k8s yaml -》启动应用

## 部署k8s yaml 
请参考 template-out-mini1 目录

## helm仓库配置
helm package webhook-helm-mini
helm repo index .
