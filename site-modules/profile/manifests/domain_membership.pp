class profile::domain_membership {

$code = " 
 $domain = "HomeLab.local"
 $machine_ou = "OU=VMs,DC=HomeLab,DC=local"
 $username='homelab\administrator'
 $password = ConvertTo-SecureString 'K@thmand0Ra' -AsPlainText -Force
 $cred=New-Object System.Management.Automation.PSCredential ("$username","$password")
 Add-Computer -DomainName "$domain" -OUPath "$machine_ou"  -Restart -Force -Credential "$cred"
"

exec { 'join_domain':
command => $code,
provider => powershell,
logoutput => true,
unless => "if ((Get-WMIObject Win32_ComputerSystem).Domain -ne '${domain}') { exit 1 }",
}
}
