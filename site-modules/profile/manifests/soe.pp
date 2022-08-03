class profile::soe {

$soe_os =$facts['os']['name']

case $soe_os{
  'windows':{
   include profile::windows
   include profile::domain_membership
  }
  'CentOS','Redhat':{
    include profile::linux
  }
  default:{
    fail("Failed")
    }
}
}


