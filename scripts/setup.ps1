Write-Host "Paso 1: Windows Update..."
# Ejecutar actualizaciones de Windows
Install-WindowsUpdate -AcceptAll -AutoReboot
Write-Host "Actualizaciones instaladas."

# Paso 2: Verificar e instalar Docker si no está presente
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "Paso 2: Docker no está instalado. Instalando Docker..."
    # Descargar e instalar Docker
    Invoke-WebRequest -Uri "https://desktop.docker.com/win/stable/Docker%20Desktop%20Installer.exe" -OutFile "$env:Temp\DockerDesktopInstaller.exe"
    Start-Process -FilePath "$env:Temp\DockerDesktopInstaller.exe" -Wait
    Write-Host "Docker instalado."
} else {
    Write-Host "Paso 2: Docker ya está instalado. Actualizando Docker..."
    # Descargar e instalar la última versión de Docker
    Invoke-WebRequest -Uri "https://desktop.docker.com/win/stable/Docker%20Desktop%20Installer.exe" -OutFile "$env:Temp\DockerDesktopInstaller.exe"
    Start-Process -FilePath "$env:Temp\DockerDesktopInstaller.exe" -Wait
    Write-Host "Docker actualizado."
}

# Paso 3: Verificar e instalar Docker Compose si no está presente
if (-not (Get-Command docker-compose -ErrorAction SilentlyContinue)) {
    Write-Host "Paso 3: Docker Compose no está instalado. Instalando Docker Compose..."
    $DOCKER_COMPOSE_VERSION = (Invoke-RestMethod -Uri "https://api.github.com/repos/docker/compose/releases/latest").tag_name
    Invoke-WebRequest -Uri "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-Windows-x86_64.exe" -OutFile "$env:ProgramFiles\Docker\docker-compose.exe"
    Write-Host "Docker Compose instalado a la versión $DOCKER_COMPOSE_VERSION."
} else {
    Write-Host "Paso 3: Docker Compose ya está instalado. Actualizando Docker Compose..."
    $DOCKER_COMPOSE_VERSION = (Invoke-RestMethod -Uri "https://api.github.com/repos/docker/compose/releases/latest").tag_name
    Invoke-WebRequest -Uri "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-Windows-x86_64.exe" -OutFile "$env:ProgramFiles\Docker\docker-compose.exe"
    Write-Host "Docker Compose actualizado a la versión $DOCKER_COMPOSE_VERSION."
}

# Paso 4: Ejecutar Docker Compose para iniciar el servidor de Minecraft
Write-Host "Paso 4: Iniciando el servidor de Minecraft con Docker Compose..."
Start-Process -FilePath "docker-compose" -ArgumentList "up -d" -NoNewWindow -Wait
Write-Host "El servidor de Minecraft se está ejecutando en segundo plano."

# Paso 5: Programar tareas para el reinicio del sistema y la ejecución de backups

# Requiere el módulo de PowerShell para el Programador de Tareas
if (-not (Get-Module -ListAvailable -Name ScheduledTasks)) {
    Install-Module -Name ScheduledTasks -Scope CurrentUser -Force
}

Import-Module ScheduledTasks

# Programar el reinicio del sistema a las 08:00 todos los días
$rebootTrigger = New-ScheduledTaskTrigger -Daily -At "08:00AM"
$rebootAction = New-ScheduledTaskAction -Execute "shutdown.exe" -Argument "/r /f /t 0"
Register-ScheduledTask -TaskName "RebootSystem" -Trigger $rebootTrigger -Action $rebootAction -RunLevel Highest

# Programar el script de backup a las 07:00 todos los días
$backupTrigger = New-ScheduledTaskTrigger -Daily -At "07:00AM"
$backupAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-File C:\ruta\a\tu\script\backup.ps1"
Register-ScheduledTask -TaskName "BackupScript" -Trigger $backupTrigger -Action $backupAction -RunLevel Highest

Write-Host "Tareas programadas añadidas."
