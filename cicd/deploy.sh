!/bin/bash
set -xe
# Deploy to k8s cluster
folder=$(pwd)

#Generate k8s folder from template
cd cicd/k8s;
IMAGE=$(echo ${CONTAINER_RELEASE_IMAGE} | sed -r 's/\//\\\//g');
MERCHANT_PATH=$(echo ${MERCHANT_EFS_CONFIG_PATH} | sed -r 's/\//\\\//g');
sed -e "s/%NAMESPACE%/${NAMESPACE}/g" -e "s/%STS_NAME%/${STS_NAME}/g" -e "s/%CONTAINER_RELEASE_IMAGE%/${IMAGE}/g" -e "s/%MERCHANT_EFS_CONFIG_PATH%/${MERCHANT_PATH}/g" -e  "s/%CONTAINERPORT%/${CONTAINERPORT}/g" stateful-template.yaml > stateful.yaml;
sed -e "s/%NAMESPACE%/${NAMESPACE}/g" -e "s/%STS_NAME%/${STS_NAME}/g" -e  "s/%CONTAINERPORT%/${CONTAINERPORT}/g" svc-template.yaml > svc.yaml;
cat svc.yaml;
cat stateful.yaml;

#Deploy
namespace=$(kubectl get ns | grep -w ^${NAMESPACE} | awk '{print $1}' | head -1);
if [ ${namespace} = ${NAMESPACE} ]
then
  stsName=$(kubectl get sts -n ${NAMESPACE} | grep -w ^${STS_NAME} | awk '{print $1}'| head -1);
  if [ ${stsName} = ${STS_NAME} ]
  then
    #Check if sts running or not
    stsStatus=$(kubectl get statefulset -n ${NAMESPACE} ${STS_NAME} | awk '{print $2}');
    #Update sts
    kubectl patch statefulset -n ${NAMESPACE} ${STS_NAME} -p '{"spec":{"updateStrategy":{"type":"RollingUpdate"}}}';
    kubectl patch statefulset -n ${NAMESPACE} ${STS_NAME} --type="json" -p="[{'op': 'replace', 'path': '/spec/template/spec/containers/0/image', 'value':'${CONTAINER_RELEASE_IMAGE}'}]";
    if [[ $stsStatus == *"0/"* ]]
    then
      echo 'StatefulSet is not running, delete pod to apply latest image';
      kubectl get pod -n ${NAMESPACE} | awk '{print $1}' | grep ${STS_NAME} | xargs kubectl delete pod -n ${NAMESPACE};
    else
      echo "Running";
    fi
  else
    kubectl apply -f stateful.yaml;
  fi
else
  #Create ns, sts, svc
  kubectl create ns ${NAMESPACE};
  kubectl apply -f stateful.yaml;
fi
kubectl apply -f svc.yaml;
