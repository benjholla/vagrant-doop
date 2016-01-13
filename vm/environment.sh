#!/bin/bash
[[ "${BASH_SOURCE[0]}" == "${0}" ]] && echo "Please source this script instead of executing it..." && exit

echo "Setting LogicBlox and DOOP environment..."
dir=$(readlink -f $(dirname ${BASH_SOURCE[0]}))

# LogicBlox version
# note that Doop does not support LogicBlox version 4!
LB_VERSION=3.10.29

# setup LogicBlox environment
export LB_MEM="8G"
export LB_MEM_NOWARN=1
export LB_PAGER_FORCE_START=1
export LOGICBLOX_HOME=${dir}/logicblox-$LB_VERSION/logicblox
export PATH=${dir}/doop/tools/bin:$LOGICBLOX_HOME/bin:$PATH

# setup Java environment
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/
export JRE_LIB=/usr/lib/jvm/java-7-openjdk-amd64/jre/lib/

# setup Doop environment
export DOOP_HOME=${dir}/doop/
export DOOP_JRE_LIB=${dir}/doop-benchmarks/JREs/
export DOOP_EXTERNALS=${dir}/doop-benchmarks/JREs

# add Doop tools to environment path
PATH=$PATH:${dir}/doop-tools/bin
export PATH
