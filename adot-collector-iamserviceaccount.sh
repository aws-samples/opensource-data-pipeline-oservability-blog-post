##!/bin/bash
CLUSTER_NAME=<cluster_name>
REGION=<region>
SERVICE_ACCOUNT_NAMESPACE=aws-otel-eks
SERVICE_ACCOUNT_NAME=aws-otel-collector
SERVICE_ACCOUNT_IAM_ROLE=EKS-ADOT-ServiceAccount-Role
SERVICE_ACCOUNT_IAM_POLICY=arn:aws:iam::aws:policy/AmazonPrometheusRemoteWriteAccess

eksctl utils associate-iam-oidc-provider \
--cluster=$CLUSTER_NAME \
--approve

eksctl create iamserviceaccount \
--cluster=$CLUSTER_NAME \
--region=$REGION \
--name=$SERVICE_ACCOUNT_NAME \
--namespace=$SERVICE_ACCOUNT_NAMESPACE \
--role-name=$SERVICE_ACCOUNT_IAM_ROLE \
--attach-policy-arn=$SERVICE_ACCOUNT_IAM_POLICY \
--override-existing-serviceaccounts \
--approve