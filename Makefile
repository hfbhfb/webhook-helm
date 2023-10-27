


helmAppName=webhook1

build-template:
	rm -Rf outdir-${helmAppName}
	touch values.yaml
	helm template webhook-helm-mini/ --namespace mywebhook --values ./values.yaml --name-template ${helmAppName} --output-dir outdir-${helmAppName} --debug

install:
	- kubectl create ns mywebhook
	helm install webhook-helm-mini/ --namespace mywebhook --values ./values.yaml --name-template ${helmAppName} 

uninstall:
	helm uninstall --namespace mywebhook ${helmAppName} 

check:
	kubectl -n mywebhook get ValidatingWebhookConfiguration webhook1-webhook-helm-mini-admission -oyaml
	kubectl -n mywebhook get MutatingWebhookConfiguration webhook1-webhook-helm-mini-admission -oyaml
	kubectl -n mywebhook get secret webhook1-webhook-helm-mini-admission -oyaml

