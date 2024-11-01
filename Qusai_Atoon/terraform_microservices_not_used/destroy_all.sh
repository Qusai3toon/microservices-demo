#!/bin/bash

directories=("database/catalogue-db" "database/carts-db" "database/orders-db" "database/session-db" "database/user-db" "microservices/catalogue" "microservices/carts" "microservices/front-end" "microservices/orders" "microservices/payment" "microservices/queue-master" "microservices/rabbitmq-exporter" "microservices/shipping" "microservices/user" "shared")

echo "Destroying all terraform.exe-managed resources..."

for dir in "${directories[@]}"; do
  echo "Processing directory: $dir"
  cd "$dir" || exit

  terraform.exe destroy -auto-approve

  cd - > /dev/null || exit
done

echo "All resources have been successfully destroyed."
