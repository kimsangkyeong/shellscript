#!/bin/sh

# Miplatform screen analyse
totcnt=0
search_files()
{
    for ix in `ls $1` 
    do
        if [ -d "$1/$ix" ]
        then
           # recursive search 
           search_files "$1/$ix"
        elif [ -f "$1/$ix" ] 
        then
           fname=`basename $ix .xml`
           fsuff=`echo $ix | awk -F . '{print $NF}'`
           if [ "xml" == $fsuff ]
           then
               #echo "$1/$ix"
               /bin/awk -f ./awk_search.cmd $1/$ix
               let totcnt=totcnt+1
           fi
        else
           echo " [$ix] -> Need to check : [$1/$ix] "
        fi
    done 
}

searchdir="/hello"
search_files $searchdir

echo "======= xml total screen count = [$totcnt] ============"
