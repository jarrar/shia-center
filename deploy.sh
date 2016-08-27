#!/bin/bash
# AUTHOR:
#set -o nounset
readonly SCRIPT=${0##*/}

function die() { echo $@; exit 1; }
function cleanup() { return 0;}

trap cleanup EXIT

function show_help()
{
    cat <<-HELP
    $SCRIPT [-d | -i | -h]

    -d | --debug           prints details logs of ansible-playbook.
    -i | --inventory  inventory file for an organization to deploy to.
    -h | --help            shows this help.
HELP
}

function init()
{
   os=$(uname)
   if [[ $os == "Darwin" ]]
   then
        GETOPT=/usr/local/Cellar/gnu-getopt/1.1.6/bin/getopt
   else
        GETOPT=$(which getopt)
   fi
}

#
# main
#
DEBUG=""
INVENTORY=""

init

TEMP=$($GETOPT -o di:h --long debug,inventory:,help -n $SCRIPT -- "$@")
eval set -- "$TEMP"

# extract options and their arguments into variables.
while true ; do
    case "$1" in
        -d|--debug)
                DEBUG="-vvvv" ; shift 1 ;;
        -i|--inventory)
                INVENTORY=$2 ; shift 2 ;;
        -h|--help)
             show_help
             exit 0
             ;;
        --) shift ; break ;;
        *) echo "Internal error!" ; exit 1 ;;
    esac
done

#[[ -z $INVENTORY ]] && die "Missing inventory file"

COPYFILE_DISABLE=1 tar -czvf web.tar.gz web
time ansible-playbook $DEBUG -i $INVENTORY deploy/deploy-web.yml
