#!/bin/bash

result=`sed 's/,/ /g' input`
echo $result > result

for i in {1..80}; do
  result=$(for v in $result; do
    if [[ $v == 0 ]]; then
      v=6
      printf "$v 8 "
    else
      (( --v ))
      printf "$v "
    fi
    
  done)
  echo $result >> result
  echo "iter #$i done"
done
echo $result | wc -w
