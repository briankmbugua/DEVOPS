#class defination
class installpackage {
  package { 'python-pip':
    ensure => 'installed',
  }
}



#class declaration
include installpackage
