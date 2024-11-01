#!/bin/bash

main_directories=("shared" "database" "microservices")

echo "Initializing and applying all terraform.exe configurations..."

for main_dir in "${main_directories[@]}"; do
  echo "Processing main directory: $main_dir"

  if [ "$main_dir" == "shared" ]; then
    cd "$main_dir" || exit
    terraform.exe init -input=false
    terraform.exe apply -auto-approve
    cd - > /dev/null || exit
  else
    for dir in "$main_dir"/*; do
      if [ -d "$dir" ]; then 
        echo "Applying terraform.exe configuration in: $dir"
        cd "$dir" || exit

        pwd
        terraform.exe init -input=false
        terraform.exe apply -auto-approve

        cd - > /dev/null || exit
      fi
    done
  fi
done

echo "All resources have been successfully deployed."
