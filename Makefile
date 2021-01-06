# environment 
CPUS          := 6
DRIVER        := docker
K8S_VERSION   := 1.20.0
MEMORY        := 8g
COMMANDS      := dashboard delete ip logs profile status stop version
.PHONY: docs casts

# tools
ASCIINEMA     := asciinema
BREW          := brew
DOCKER        := docker
EDITOR        := vim 
FIGLET        := figlet
FIND          := find
GREP          := grep 
KUBECTL       := kubectl
MINIKUBE      := minikube
SHELL         := bash
SORT          := sort
SUDO          := sudo
VISIDATA      := vd
XARGS         := xargs

MINIKUBE_IP   := $(shell $(MINIKUBE) ip)

help: Makefile    ; @$(GREP) -Eo "^[a-zA-Z0-9_]+:" $< | $(SORT)         
brew: Brewfile    ; $(BREW) bundle install $<
$(COMMANDS):      ; $(MINIKUBE) $@
edit: Makefile    ; $(EDITOR) $<
addons:           ; $(MINIKUBE) $@ list
start:            ; $(MINIKUBE) $@ --cpus=$(CPUS) --memory=$(MEMORY) --kubernetes-version=$(K8S_VERSION)  --driver=$(DRIVER)
foo:

step1:  brew           
	@ $(DOCKER) version || echo "please ensure docker is running"
step2:            delete start
	@echo "ctl-c after checking out the dashboard"
	$(MINIKUBE) dashboard
step3:
	$(MINIKUBE) addons enable metrics-server
	$(MINIKUBE) addons list
	@ echo $(MINIKUBE_IP)
	MINIKUBE_IP=$(MINIKUBE_IP) $(SUDO) $(MINIKUBE) tunnel
step4:
	mkdir -p $$PWD/cf-for-k8s-tmp
	git clone https://github.com/cloudfoundry/cf-for-k8s.git -b main
 
docs:             ; open https://github.com/pauldougan/cf4minikube/blob/main/docs/resources.md

clean:
	rm -rvf cf-for-k8s
	rm -rvf cf-for-k8s-tmp
	$(MINIKUBE) delete --all
	rm -rvf ~/.minikube

nodes namespaces:    ; $(KUBECTL) get namespaces
pods :               ; $(KUBECTL) get pods --all-namespaces
casts:               ; $(FIND) casts -iname "*.cast" | $(VISIDATA) - | $(XARGS) -n 1 $(ASCIINEMA) play             

foo: 
	echo $(MINIKUBE_IP)
