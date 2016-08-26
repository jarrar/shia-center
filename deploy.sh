#!/bin/bash
# Copyright (c) 1999 Cisco Systems, Inc.  All rights reserved.
# AUTHOR:  Jarrar Jaffari (), jjaffari@cisco.com
set -o nounset
readonly SCRIPT=${0##*/}

function die() { echo $@; exit 1; }
function cleanup() { return 0;}

trap cleanup EXIT

function show_help()
{
    cat <<-HELP
    $SCRIPT [-h | -a ]
HELP
}

#
# main
#

#TEMP=$(getopt -o a:h --long arga:,help -n $SCRIPT -- "$@")
#eval set -- "$TEMP"

# extract options and their arguments into variables.
#while true ; do
#    case "$1" in
#        -a|--arga)
#                ARG_A=$2 ; shift 2 ;;
#        -h|--help)
#             show_help
#             exit 0
#             ;;
#        --) shift ; break ;;
#        *) echo "Internal error!" ; exit 1 ;;
#    esac
#done

# defaults
#ARG_A=${ARG_A:='Some value'}

COPYFILE_DISABLE=1 tar -czvf web.tar.gz web
time ansible-playbook -vvvv -i deploy/iabat.inv deploy/deploy-web.yml
