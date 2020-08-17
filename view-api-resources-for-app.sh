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
echo "*** This script can take some time to complete ***"
echo ""

kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl get --show-kind --ignore-not-found -n cf-workloads -l cloudfoundry.org/app_guid=$APP_GUID
