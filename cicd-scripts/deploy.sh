oc login $KUBE_URL --token=$KUBE_TOKEN --insecure-skip-tls-verify

OUTPUT=$(helm history --max 1 $CI_PROJECT_NAME-$1 --namespace $KUBE_NAMESPACE 2>/dev/null | grep failed | cut -f1 | grep 1)
EXPECTED_OUTPUT=1

if [ X"$OUTPUT" = X"$EXPECTED_OUTPUT" ]
then
  helm delete $CI_PROJECT_NAME-$1 --namespace $KUBE_NAMESPACE
fi 

helm upgrade --install --set image.apiImage=$CI_REGISTRY_IMAGE/$CI_PROJECT_NAME:$CI_PIPELINE_ID-$1 --set deployment.environment=$1 $CI_PROJECT_NAME-$1 ./helm-chart --namespace $KUBE_NAMESPACE