if [ -z "$1" ]
  then
    echo "No application route supplied"
    exit 1;
fi

host $1
