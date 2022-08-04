class profile::domain_membership {
exec { 'join_domain':
command => file('profile/dj.ps1'),
provider => powershell,
unless => "if ((Get-WMIObject Win32_ComputerSystem).Domain -ne 'homelab.local') { exit 1 }",
}
}
