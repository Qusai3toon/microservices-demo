#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <path_to_resources>"
  exit 1
fi


BASE_DIR=$1


if [ ! -d "$BASE_DIR" ]; then
  echo "Error: Directory $BASE_DIR does not exist."
  exit 1
fi

echo "Starting deployment in directory: $BASE_DIR"

if [ -f "$BASE_DIR/namespace/namespace.yaml" ]; then
  echo "Deploying namespace..."
  kubectl apply -f "$BASE_DIR/namespace/namespace.yaml"
  if [ $? -ne 0 ]; then
    echo "Error applying namespace.yaml"
    exit 1
  fi
fi

for RESOURCE_DIR in "$BASE_DIR"/*; do
  if [ -d "$RESOURCE_DIR" ] && [ "$(basename "$RESOURCE_DIR")" != "namespace" ]; then
    echo "Deploying resources in $(basename "$RESOURCE_DIR")..."

    for YAML_FILE in "$RESOURCE_DIR"/*.yaml; do
      if [ -f "$YAML_FILE" ]; then
        echo "Applying $YAML_FILE..."
        kubectl apply -f "$YAML_FILE"
        if [ $? -ne 0 ]; then
          echo "Error applying $YAML_FILE"
          exit 1
        fi
      fi
    done
  fi
done

echo "Deployment complete."
