class profile::soe {

$soe_os =$facts['os']['name']

case $soe_os{
  'windows':{
   include profile::windows
  }
  'CentOS','Redhat':{
    include profile::linux
  }
  default:{
    fail("Failed")
    }
}
}


