if [ -z "$1" ]
  then
    echo "No cf-system component name applied"
    exit 1;
fi

component=$1; shift
kapp logs -a cf -m $component% $@

