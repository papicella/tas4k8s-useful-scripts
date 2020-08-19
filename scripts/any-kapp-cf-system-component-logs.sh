if [ -z "$1" ]
  then
    echo "No cf-system component name applied"
    exit 1;
fi

kapp logs -a cf -m $1%
