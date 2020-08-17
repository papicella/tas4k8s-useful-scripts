if [ -z "$1" ]
  then
    echo "No application name supplied"
    exit 1;
fi

export APP_GUID=`cf app $1 --guid`

echo ""
echo "Using application name: $1"
echo "Using application GUID as: $APP_GUID"

echo ""
echo "Pods ..."
echo ""

kubectl get pods -l cloudfoundry.org/app_guid=$APP_GUID -n cf-workloads

echo ""
echo "Service ..."
echo ""

kubectl get service -l cloudfoundry.org/app_guid=$APP_GUID -n cf-workloads

echo ""
echo "Stateful Set ..."
echo ""

kubectl get statefulset  -l cloudfoundry.org/app_guid=$APP_GUID -n cf-workloads

echo ""
echo "Build ..."
echo ""

kubectl get  build -n cf-workloads-staging -l cloudfoundry.org/app_guid=$APP_GUID
