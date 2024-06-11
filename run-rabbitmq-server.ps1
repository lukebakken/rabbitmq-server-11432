$ProgressPreference = 'Continue'
$ErrorActionPreference = 'Stop'
Set-StrictMode -Version 2.0

Write-Host "[INFO] script directory: $PSScriptRoot"

[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor 'Tls12'

$rabbitmq_version='3.13.3'
$rabbitmq_dir = Join-Path -Path $PSScriptRoot -ChildPath "rabbitmq_server-$rabbitmq_version"
$rabbitmq_sbin = Join-Path -Path $rabbitmq_dir -ChildPath 'sbin'
$rabbitmq_download_url = "https://github.com/rabbitmq/rabbitmq-server/releases/download/v$rabbitmq_version/rabbitmq-server-windows-$rabbitmq_version.zip"
$rabbitmq_zip_file = Join-Path -Path $PSScriptRoot -ChildPath "rabbitmq-server-windows-$rabbitmq_version.zip"
$rabbitmq_server_cmd = Join-Path -Path $rabbitmq_sbin -ChildPath 'rabbitmq-server.bat'

$rabbitmq_base = Join-Path -Path $PSScriptRoot -ChildPath 'rmq'

$rabbitmq_conf_in = Join-Path -Path $PSScriptRoot -ChildPath 'rabbitmq.conf'
$rabbitmq_conf_out = Join-Path -Path $rabbitmq_base -ChildPath 'rabbitmq.conf'

$enabled_plugins_in = Join-Path -Path $PSScriptRoot -ChildPath 'enabled_plugins'
$enabled_plugins_out = Join-Path -Path $rabbitmq_base -ChildPath 'enabled_plugins'

$env:RABBITMQ_BASE = $rabbitmq_base

if (!(Test-Path -Path $rabbitmq_dir))
{
    New-Item -Path $rabbitmq_base -ItemType Directory
    Invoke-WebRequest -Verbose -UseBasicParsing -Uri $rabbitmq_download_url -OutFile $rabbitmq_zip_file
    Expand-Archive -Path $rabbitmq_zip_file -DestinationPath $PSScriptRoot
}

Copy-Item -Verbose -Force -LiteralPath $rabbitmq_conf_in -Destination $rabbitmq_conf_out
Copy-Item -Verbose -Force -LiteralPath $enabled_plugins_in -Destination $enabled_plugins_out

& $rabbitmq_server_cmd
