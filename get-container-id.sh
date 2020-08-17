if [ -z "$1" ]
  then
    echo "No application name supplied"
    exit 1;
fi

export APP_GUID=`cf app $1 --guid`

kubectl get pods -l cloudfoundry.org/app_guid=$APP_GUID -n cf-workloads -o=jsonpath='{.status.hostIP},{.status.containerStatuses[0].containerID}'

#kubectl get pods -l cloudfoundry.org/app_guid=$APP_GUID -n cf-workloads -o yaml


