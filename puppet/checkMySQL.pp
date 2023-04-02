#class defination
class executecommand {
  exec { 'checkMySQl':
    command   => '/bin/systemctl status mongod',
    logoutput => true
  }
}
#class declaration
include executecommand
