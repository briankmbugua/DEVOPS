#class defination
class createafile {
  file {'/home/letbmk/Desktop/school':
ensure  => 'present',
content =>'I love Puppet',
mode    =>'0744',
owner   =>'www-data',
group   =>'www-data'
  }
}
#class declaration
include createafile

