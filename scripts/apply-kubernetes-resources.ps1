# Define los archivos YAML en el orden correcto
$files = @(
    "./kubernetes/minecraft-server-namespace.yaml"
    "./kubernetes/minecraft-server-secrets.yaml"
    "./kubernetes/minecraft-server-configmap.yaml"
    "./kubernetes/minecraft-server-persistent-volume.yaml"
    "./kubernetes/minecraft-server-persistent-volume-claim.yaml"
    "./kubernetes/minecraft-server-deployment.yaml"
    "./kubernetes/minecraft-server-service.yaml"
)

# Itera sobre cada archivo y aplícalo con kubectl
foreach ($file in $files) {
    kubectl delete -f $file --ignore-not-found=true
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Error al eliminar los recursos de $file. Salida del error: $(kubectl delete -f $file 2>&1). Abortando."
        exit 1
    }
    Write-Output "Aplicando $file"
    kubectl apply -f $file
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Error al aplicar $file. Abortando."
        exit 1
    }
}

Write-Output "Todos los archivos YAML se han aplicado correctamente."
