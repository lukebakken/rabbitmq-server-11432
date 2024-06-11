$ProgressPreference = 'Continue'
$ErrorActionPreference = 'Continue'
Set-StrictMode -Version 2.0

$username = "testUser6"
$password = '"w63pnZ&LnYMO(t"'

$rabbitmq_version='3.13.3'
$rabbitmq_dir = Join-Path -Path $PSScriptRoot -ChildPath "rabbitmq_server-$rabbitmq_version"
$rabbitmq_sbin = Join-Path -Path $rabbitmq_dir -ChildPath 'sbin'
$local_sbin = Join-Path -Path $PSScriptRoot -ChildPath 'sbin'
$rabbitmqctl_cmd_in = Join-Path -Path $local_sbin -ChildPath 'rabbitmqctl.bat'
$rabbitmqctl_cmd = Join-Path -Path $rabbitmq_sbin -ChildPath 'rabbitmqctl.bat'

Copy-Item -Verbose -Force -LiteralPath $rabbitmqctl_cmd_in -Destination $rabbitmqctl_cmd

& echoargs.exe $rabbitmqctl_cmd add_user "$username" "$password"
& $rabbitmqctl_cmd add_user "$username" "$password"

& echoargs.exe $rabbitmqctl_cmd authenticate_user "$username" "$password"
& $rabbitmqctl_cmd authenticate_user "$username" "$password"

& echoargs.exe $rabbitmqctl_cmd delete_user "$username"
& $rabbitmqctl_cmd delete_user "$username"
