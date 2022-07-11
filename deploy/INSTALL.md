1. Install Docker https://docs.docker.com/engine/install/ubuntu/
2. Install kubeadm https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
3. sudo rm /etc/containerd/config.toml
4. sudo systemctl restart containerd
5. sudo adduser deploy --disabled-password && sudo passwd -d deploy + copy authorized_keys
6. Add deploy to docker and sudo groups
7. Reboot
8. sudo kubeadm init --pod-network-cidr=10.244.0.0/16
9. sudo deluser deploy sudo
10. Untaint https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#control-plane-node-isolation
11. Apply Flannel https://github.com/flannel-io/flannel#flannel
12. https://kubernetes.github.io/ingress-nginx/deploy/#bare-metal-clusters and set ClusterIP
13. Install nginx
14. Install Snap and Certbot https://certbot.eff.org/instructions?ws=nginx&os=ubuntufocal
