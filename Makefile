# environment 
CPUS          := 6
DRIVER        := docker
K8S_VERSION   := 1.19.2
MEMORY        := 8g
COMMANDS      := dashboard delete ip logs profile status stop version

# tools
ASCIINEMA     := asciinema
BREW          := brew
EDITOR        := vim 
GREP          := grep 
KUBECTL       := kubectl
MINIKUBE      := minikube
SORT          := sort

help: Makefile    ; @$(GREP) -Eo "^[a-zA-Z0-9_]+:" $< | $(SORT)         
brew: Brewfile    ; $(BREW) bundle install $<
$(COMMANDS):      ; $(MINIKUBE) $@
edit: Makefile    ; $(EDITOR) $<
addons:           ; $(MINIKUBE) $@ list
start:            ; $(MINIKUBE) $@ --cpus=$(CPUS) --memory=$(MEMORY) --kubernetes-version=$(K8S_VERSION)  --driver=$(DRIVER)
step1:  brew           
	echo "please ensure docker is running"
step2:            delete start
step3:
	$(MINIKUBE) addons enable metrics-server
	$(MINIKUBE) addons list
	$(MINIKUBE) ip
	
docs:             ; open https://starkandwayne.com/blog/running-cf-for-k8s-on-minikube/?vgo_ee=rRAPjg%2FWVjzMES6Pz3beI0pak%2BOYOV%2Bn%2BAKg6Zw1pDTQykVaBNHrp5UXoRd9dBvk

clean:
	rm -rvf cf-for-k8s
	rm -rvf cf-for-k8s-tmp
	$(MINIKUBE) delete

nodes namespaces:    ; $(KUBECTL) get namespaces
pods :               ; $(KUBECTL) get pods --all-namespaces
