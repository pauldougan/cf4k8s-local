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
FIND          := find
GREP          := grep 
KUBECTL       := kubectl
MINIKUBE      := minikube
SHELL         := bash
SORT          := sort
VISIDATA      := vd
XARGS         := xargs

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
step3:
	$(MINIKUBE) addons enable metrics-server
	$(MINIKUBE) addons list
	$(MINIKUBE) ip
	
docs:             ; open https://github.com/pauldougan/cf4minikube/blob/main/docs/resources.md

clean:
	rm -rvf cf-for-k8s
	rm -rvf cf-for-k8s-tmp
	$(MINIKUBE) delete --all
	rm -rvf ~/.minikube

nodes namespaces:    ; $(KUBECTL) get namespaces
pods :               ; $(KUBECTL) get pods --all-namespaces
casts:               ; $(FIND) casts -iname "*.cast" | $(VISIDATA) - | $(XARGS) -n 1 $(ASCIINEMA) play             
