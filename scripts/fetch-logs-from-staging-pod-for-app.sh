if [ -z "$1" ]
  then
    echo "No application name supplied"
    exit 1;
fi

export APP_GUID=`cf app $1 --guid`

echo ""
echo "Using application name: $1"
echo "Using application GUID as: $APP_GUID"

kubectl logs -l cloudfoundry.org/source_type=STG -l cloudfoundry.org/app_guid=$APP_GUID -n cf-workloads-staging --all-containers --max-log-requests=8

