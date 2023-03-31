# Class defination
class ntpconfig {
  file {"/home/letbmk/Desktop/frompuppet.conf":
  ensure=>"present",
  content=>"frompuppet"
  }
}
# class Declaration
include ntpconfig
