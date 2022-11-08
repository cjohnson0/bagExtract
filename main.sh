#!/bin/env bash
#
# This script populates target directory ($1) with .jsonFiles through ./jsonPopulate.sh then for each .bag.json File Pair, 
# Then it gets the desired path starting at routeRoot ($2) through reading the .jsonFile through calling getRoute.py
# Then it goes to the routeRoot and follows the path, (or builds it if it doesn't exist)                                                         
#
# $1 - (bagPath)
# $2 - routeRoot (where the path wants to be built from)
#
# USAGE HELP:          ./main.sh bagDirectory routeRoot
# USAGE EXAMPLE:       /main.sh ../bags ../sorted
#

A_PROGRAM_HOME=`pwd`

r_TARGET_BAG_DIR=$1
cd $r_TARGET_BAG_DIR
A_TARGET_BAG_DIR=`pwd` # $1 can be a relative path, convert to absolute path for future use.
cd ~-
r_ROUTE_ROOT=$2
cd $r_ROUTE_ROOT
A_ROUTE_ROOT=`pwd` # $2 can be a relative path, convert to absolute path for future use.
cd ~-
$A_PROGRAM_HOME/jsonPopulate.sh $A_TARGET_BAG_DIR
errorPath=$A_TARGET_BAG_DIR/missing.txt
errorFile=missing.txt

for jsonFile in $A_TARGET_BAG_DIR/*json; do
    bagName=${jsonFile%.*}.bag
    bagFile=$(basename ${bagName})
    if [ -f ${bagPathName} ]; then

       if  $(! grep -q $bagFile $errorPath)  ; then
            echo "Complete bagFile/jsonFile Pair Found: $bagFile $jsonFile"
            python3 $A_PROGRAM_HOME/getRoute.py $jsonFile $A_ROUTE_ROOT  ### -p ROUTE_DIR
        else
            echo "$bagFile found in $errorFile, skipping path creation."
       fi

    fi
    # PATH IS MADE
    # USE NETWORK INPUT TO EXTRACT THEM
done
