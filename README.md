# Vagrant Doop
This repository contains a Vagrant configuration with support for the Doop Java pointer analysis framework.

## Overview
[Doop](http://doop.program-analysis.org) is a framework for performing pointer analysis on Java bytecode. Doop runs on a commercial Datalog engine called [LogicBlox](http://www.logicblox.com/). This project is a fork of the [LogicBlox Vagrant project](https://bitbucket.org/logicblox/lb-vagrant), which is the preferred way to deploy the LogicBlox Datalog engine. To use this project you will need to obtain a copy of LogicBlox version 3 (Doop does not support version 4).  You can [request an academic license](http://www.logicblox.com/learn/academic-license-request-form/) for LogicBlox. This project sets up the latest version of Doop hosted at [bitbucket.org/yanniss/doop](https://bitbucket.org/yanniss/doop) with a similar setup to PLDI 2015 tutorial at  [plast-lab.github.io/doop-pldi15-tutorial](https://plast-lab.github.io/doop-pldi15-tutorial/).

## Setup
1. Download and install [VirtualBox](https://www.virtualbox.org/) and [Vagrant](http://www.vagrantup.com/) for your host machine.

2. Clone this repository `git clone https://github.com/benjholla/vagrant-doop.git` on your host machine.

3. Download the LogicBlox version 3 tar file and place it in the `vagrant-doop/vm` directory. If the version of LogicBlox does not match `3.10.29` then edit the value of `LB_VERSION` in the [environment.sh](https://github.com/benjholla/vagrant-doop/blob/master/vm/environment.sh#L9) file. Note that currently Doop does not support LogicBlox version 4!

4. DOOP can be a very memory intensive application.  The recommended amount of memory for DOOP is 8-16 gigabytes of memory.  You may need to increase or decrease the memory settings (depending on your needs) in the [environment.sh](https://github.com/benjholla/vagrant-doop/blob/master/vm/environment.sh#L12) for LogicBlox and in the [Vagrantfile](https://github.com/benjholla/vagrant-doop/blob/master/vm/Vagrantfile#L24) for the virtual machine itself.

5. On the command line, navigate to the `vm` directory of the cloned `vagrant-doop` respository and run `vagrant up`.

6. After the Vagrant VM is finished setting up run `vagrant ssh` to ssh to the machine.  To exit from ssh session run `exit` in the Vagrant VM. To halt the VM run `vagrant halt` from the host machine.  To remove the VM from the host run `vagrant destroy`.

7. After running `vagrant ssh` to get a session on the Vagrant VM, ensure you are in the `/home/vagrant/` directory and then set the LogicBlox and Doop environment variables by running `source environment.sh`.

8. To test Doop with the [Doop PLDI 2015 Tutorial](https://plast-lab.github.io/doop-pldi15-tutorial/) example navigate within the Vagrant VM to `/home/vagrant/examples/` and run `mkjar Example.java` to compile the example.  Next navigate to `/home/vagrant/doop/` and process the bytecode by running `./doop -a naive -j ../examples/Example.jar -Xstats:none`. Finally query the results by running `bloxbatch -db last-analysis -query '_(?var, ?heap) <- VarPointsTo(?var, ?heap), Var:DeclaringMethod(?var, "<Example: void morePlay(Cat)>").'`. For more details on running Doop see the tutorial.
