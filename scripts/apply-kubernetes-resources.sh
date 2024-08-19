#!/bin/sh

# Define los archivos YAML en el orden correcto
files=(
  "minecraft-server-namespace.yaml"
  "minecraft-server-secrets.yaml"
  "minecraft-server-configmap.yaml"
  "minecraft-server-persistent-volume.yaml"
  "minecraft-server-persistent-volume-claim.yaml"
  "minecraft-server-deployment.yaml"
  "minecraft-server-service.yaml"
)

# Itera sobre cada archivo y aplícalo con kubectl
for file in "${files[@]}"; do
  echo "Aplicando $file"
  kubectl apply -f "$file"
  if [ $? -ne 0 ]; then
    echo "Error al aplicar $file. Abortando."
    exit 1
  fi
done

echo "Todos los archivos YAML se han aplicado correctamente."
