class profile::domain_membership (
  $domain = 'HomeLab.local',
  $username = 'administrator',
  $password = 'K@thmand0Ra',
  $secure_password = false,
  $machine_ou      = 'OU=VMs,DC=HomeLab,DC=local',
){

$code = " \
\$secStr=ConvertTo-SecureString '${password}' -AsPlainText -Force; \
if (-not \$?) { \
write-error 'Error: Unable to convert password string to a secure string'; \
exit 10; \
} \
\$creds=New-Object System.Management.Automation.PSCredential( '${username}', \$secStr ); \
if (-not \$?) { \
write-error 'Error: Unable to create PSCredential object'; \
exit 20; \
} \
Add-Computer -DomainName ${domain}  -Restart -Force -Cred \$creds; \
if (-not \$?) { \
write-error 'Error: Unable to join domain'; \
exit 30; \
} \
exit 0"

#
# Use the Josh Cooper PowerShell provider
#
exec { 'join_domain':
command => $code,
provider => powershell,
logoutput => true,
unless => "if ((Get-WMIObject Win32_ComputerSystem).Domain -ne '${domain}') { exit 1 }",
}
}
