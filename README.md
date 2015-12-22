# Vagrant Doop
This repository contains a Vagrant configuration with support for the Doop Java pointer analysis framework.

## Overview
[Doop](http://doop.program-analysis.org) is a framework for performing pointer analysis on Java bytecode. Doop runs on a commercial Datalog engine called [LogicBlox](http://www.logicblox.com/). This project is a fork of the [LogicBlox Vagrant project](https://bitbucket.org/logicblox/lb-vagrant), which is the preferred way to deploy the LogicBlox Datalog engine. To use this project you will need to obtain a copy of LogicBlox version 3 (Doop does not support version 4).  You can [request an academic license](http://www.logicblox.com/learn/academic-license-request-form/) for LogicBlox. This project sets up the latest version of Doop hosted at [bitbucket.org/yanniss/doop](https://bitbucket.org/yanniss/doop) with a similar setup to PLDI 2015 tutorial at  [plast-lab.github.io/doop-pldi15-tutorial/](https://plast-lab.github.io/doop-pldi15-tutorial/).

## Setup
1. Download and install [VirtualBox](https://www.virtualbox.org/) and [Vagrant](http://www.vagrantup.com/) for your host machine.
2. Clone this repository `git clone https://github.com/benjholla/vagrant-doop.git` on your host machine.
3. Download the LogicBlox version 3 tar file and place it in the `vagrant-doop/vm` directory. If the version of LogicBlox does not match `3.10.29` then edit the value of `LB_VERSION` in the [environment.sh](https://github.com/benjholla/vagrant-doop/blob/master/vm/environment.sh) file. Note that currently Doop does not support LogicBlox version 4!
4. On the command line, navigate to the `vm` directory of the cloned `vagrant-doop` respository and run `vagrant up`.
