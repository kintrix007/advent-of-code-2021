#!/bin/bash

one=0
four=0
seven=0
eight=0

while read l; do
  for w in ${l##*| }; do
    len=${#w}
    # printf "$w(${#w}) "
    [[ $len = 2 ]] && ((one++))
    [[ $len = 3 ]] && ((seven++))
    [[ $len = 4 ]] && ((four++))
    [[ $len = 7 ]] && ((eight++))
  done
  # echo ""
done < input

echo $((one + four + seven + eight))