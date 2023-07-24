##!/bin/bash
curl -o iam-policy.json https://raw.githubusercontent.com/kubernetes-sigs/awsload-balancer-controller/v2.4.7/docs/install/iam_policy.json
aws iam create-policy \
	--policy-name AWSLoadBalancerControllerIAMPolicy \
	--policy-document file://iam-policy.json \
	--tags Key=alpha.eksctl.io/cluster-name,Value=<cluster-name> \

eksctl create iamserviceaccount \
	--cluster=<cluster-name> \
	--namespace=kube-system \
	--name=aws-load-balancer-controller \
	--attach-policy-arn=arn:aws:iam::<account_id>:policy/AWSLoadBalancerControllerIAMPolicy \
	--override-existing-serviceaccounts \
	--region ap-southeast-2 \
	--approve
	
wget https://github.com/kubernetes-sigs/aws-load-balancercontroller/releases/download/v2.4.7/v2_4_7_full.yaml

kubectl apply -f v2_4_7_full.yaml

wget https://github.com/kubernetes-sigs/aws-load-balancercontroller/releases/download/v2.4.7/v2_4_7_ingclass.yaml