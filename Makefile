


helmAppName=mini1
Space=webhookmini

# test2: build-template
# 	echo "test2"


all:codeandimage uninstall build-template install
	sleep 5; make checkrunok;


install:
	- kubectl create ns ${Space}
	helm install webhook-helm-mini/ --namespace  ${Space} --values ./values.yaml --name-template ${helmAppName} 

uninstall:
	- kubectl delete ns ${Space} 
	- helm uninstall --namespace  ${Space} ${helmAppName} 
	- kubectl  delete ValidatingWebhookConfiguration ${helmAppName}-webhook-helm-mini-admission 
	- kubectl  delete MutatingWebhookConfiguration ${helmAppName}-webhook-helm-mini-admission 
	- kubectl  delete -n  ${Space} secret ${helmAppName}-webhook-helm-mini-admission
	- kubectl -n  ${Space} get secret ${helmAppName}-webhook-helm-mini-admission -oyaml

build-template:
	rm -Rf template-out-${helmAppName}
	touch values.yaml
	helm template webhook-helm-mini/ --namespace  ${Space} --values ./values.yaml --name-template ${helmAppName} --output-dir template-out-${helmAppName} --debug

codeandimage:
	cd code-webhook-mini && make

check:
	kubectl  get ValidatingWebhookConfiguration ${helmAppName}-webhook-helm-mini-admission -oyaml
	kubectl  get MutatingWebhookConfiguration ${helmAppName}-webhook-helm-mini-admission -oyaml
	kubectl -n  ${Space} get secret ${helmAppName}-webhook-helm-mini-admission -oyaml

checkrunok:
	- kubectl delete ns ns12
	- kubectl create ns ns12
	- kubectl label namespace ns12 webhook-mini=enabled
	- kubectl create -n ns12 deployment dep1 --image=nginx --replicas=1 # 期望失败，因为没有相应的label
	- kubectl delete -f dep2.yaml;kubectl apply -f dep2.yaml # kubectl create -n ns12 deployment dep2 --image=nginx --replicas=1 --dry-run -oyaml


