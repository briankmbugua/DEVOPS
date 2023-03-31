# Check if SSH key exists on Ubuntu
```bash
ls -al ~/.ssh
```
# puppet
Puppet is a configuration management technology to manage the infrastructure on physical or virtual machines.
# Fetures of Puppet System
## idempotency
One can safely run the same set of configuration multiple times on the same machine.
## Cross-platform
One can target the specified configuration of a system without worrying about the implementation details and how the configuration command will work inside the system.
# Puppet - Workflow
- collect details of the target machine and send them back to the puppet master
- puppet master compares the retrieved configuration details, and creates a catalog and sends it to the targeted puppet agents
- puppet agent then applies those configurations to get the system into a desired state
- Once the target node is in a desired state, it sends back a report to the puppet master.
# Deployment models of configuration management tools
- push-based deployment model:initiated by a master node, master server pushes the configurations and software to the individual agents, the master runs commands remotely on agents.Ansible and Salt Stack.
- pull-based deployment model:initiated by agents - contact a master server and download configurations and software and then configure themselves accordingly.puppet and chef

Puppet is based on a pull deployment model.

# The Master
A linux based machine with puppet master software installed.It is responsible for maintaining configurations in the form of puppet codes.The master node can only be linux.
# The Agents
The target machine managed by a puppet with the puppet agent software installed on them.
## Communication between the master and the agent
- step1) Once connectivity is established between the agent and the master, the puppet agent sends the data about it's state to the puppet master server.These are called facts e.g hostname, kernel details, ip address, file name details,etc...
- step2) Puppet master uses the data and compiles a list with the configuration to be applied to the agent.This list to be perfomed on an agent is called catalog.This could be changed such as package installation, upgrades or removals, File System Creation, user creation or deletion, server reboot, ip configuration details.
- step3) The agent uses this list of configuration to apply any required configuration changes to the node.
- step4) Once it is done the node reports back to puppet master indicating that the configuration has been applied and completed.

# Puppet Blocks
 - Resources
 - classes
 - manifest
 - modules
 ## puppet resources
 are the building blocks of puppet, they are inbuilt functions that run at the back end to perform required operations on puppet
 ## puppet classes
 A combination of resources can be combined togethor into a single unit called a class
 ## puppet manifest
 Manifest is a directory containing puppet DSL files.Those files have a .pp extension.The .pp extension stands for puppet program.The puppet code consists of definations or declarations of puppet classes.
 ## puppet modules
 a collection of files and directories such as manifests, class definations.
 They are re-usable and sharable units in Puppet.
 E.g MySQL module to install and configure MySQL or jenkins module to manage jenkins.

 # Types of puppet resources
 A System contains of files, users, services, processes, packages.In puppet these are called resources.
 Puppet resources are readymade tools that are used to perform various tasks and operations on any supported platform.
 Resources can have different types.Puppet uses resources and resource types in order to describe a systems configuration.
 ## Three kinds of resources
 - Puppet core or built-in resources - built-in shiped with the puppet software
 - Puppet defined resource types - Written in puppet declarative language using a combination of existing resources
 - puppet custom resource type - completely customized resources written in Ruby.
```bash
 puppet --help a list of puppet relevant subcommands
 puppet resource -types
 puppet describe <resource type name>
```

# What are Puppet Classes
collection of puppet resources bundled togethor as a single unit.
to create a class, define a class using class defination syntax; classes must be unique and can be declared only once with the same name
```.pp
class <class-name> {
    <Resource declarations>
}
```
```bash
class ntpconfig {
    file {
        "/etc/ntp.conf":
        ensure=> "present",
        content=> "Server 0.centos.pool.ntp.orgiburst\n"
    }
}
# class declaration
include ntpconfig
```