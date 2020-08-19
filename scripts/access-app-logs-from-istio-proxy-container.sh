if [ -z "$1" ]
  then
    echo "No application name  supplied"
    exit 1;
fi

kubectl logs -l cloudfoundry.org/app_guid=`cf app $1 --guid` -n cf-workloads -c istio-proxy -f
