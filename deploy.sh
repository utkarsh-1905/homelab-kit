#!/bin/bash

declare name
declare host
declare -i port
declare network="web"
generate_dns_record=0

show_help(){
    echo "Usage: deploy.sh -c <container_name> -h <host> -p <port> -n <network>"
    echo "Example: deploy.sh -c blogapi -h blogapi.example.com -p 4000 -n web"
    echo "Default network is web"
}

while getopts ":c:h:gp:n:" opt; do
  case $opt in
    c)
      name=${OPTARG}
      ;;
    h)
      host=${OPTARG}
      ;;
    g)
      generate_dns_record=1
      ;;
    p)
      port=${OPTARG}
      ;;
    n)
      network=${OPTARG}
      ;;
    \?)
      show_help
      ;;
  esac
done

deploy_container(){
    sudo docker stop $name
    sudo docker rm $name
    sudo docker rmi $name-image:latest
    sudo docker build -t $name-image:latest .
    sudo docker run -d -p --net $network --name $name -l traefik.http.routers.$name.rule="Host(\`$host\`)" -l traefik.http.routers.$name.tls=true -l traefik.http.routers.$name.tls.certresolver=lets-encrypt -l traefik.port=80 $name-image
}

create_dns_record(){
    if (($generate_dns_record > 0)); then
        echo "Creating DNS record for $host"

        host_length=${#host}

        if (($host_length > 0)); then
            IFS="." #special variable to specify the delimiter
            read -ra subd <<< $host
            echo $subd
        else
            echo "Specify the host name first"
            exit 0
        fi

        curl -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
        -H "X-Auth-Email: $CLOUDFLARE_EMAIL" \
        -H "Authorization: Bearer $CLOUDFLARE_API_KEY" \
        -H "Content-Type: application/json" \
        --data '{"type":"A","name":'${subd[0]}',"content":'$SERVER_IP',"proxied":false}'

    fi
}
create_dns_record