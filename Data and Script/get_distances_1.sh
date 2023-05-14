#!/bin/bash

#################################################
# get_distances.sh
#
#   Script iteratively calls gmx distance and
#   assembles a series of COM distance values
#   indexed by frame number, for use in
#   preparing umbrella sampling windows.
#
# Written by: Justin A. Lemkul, Ph.D.
#    Contact: jalemkul@vt.edu
#
#################################################
# compute distances
for (( i=0; i<601; i++ ))
do
    gmx distance -s pull_umbrella_3.tpr -f conf_umbrella_3${i}.gro -n index_pull_umbrella_4.ndx -select 'com of group "P_5" plus com of group "P_6"' -oall dist${i}.xvg 
done

# compile summary
touch summary_distances_3_1.dat
for (( i=0; i<601; i++ ))
do
    d=`tail -n 1 dist${i}.xvg | awk '{print $2}'`
    echo "${i} ${d}" >> summary_distances_3_1.dat
    rm dist${i}.xvg
done

exit;