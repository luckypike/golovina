1. Install Docker https://docs.docker.com/engine/install/ubuntu/
2. Install kubeadm https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
3. Set systemd https://github.com/kubernetes/kubeadm/issues/1394#issuecomment-461443286 / sudo su - root
4. Add deploy user
5. Add deploy to docker and sudo groups
6. Reboot
7. sudo kubeadm init --pod-network-cidr=10.244.0.0/16
7. deluser deploy sudo
8. Untaint https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#control-plane-node-isolation
9. Apply Flannel https://github.com/flannel-io/flannel#flannel
10. Install Composer https://docs.docker.com/compose/install/
11. https://kubernetes.github.io/ingress-nginx/deploy/#bare-metal-clusters and set ClusterIP
12. Install nginx
13. Install Snap and Certbot https://certbot.eff.org/instructions?ws=nginx&os=ubuntufocal
