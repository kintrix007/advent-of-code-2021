#!/bin/bash

input=`cat input`

count() {
  for number in {0..8}; do
    echo $(printf "${input//[^$number]/}" | wc -m)
  done
}

amounts=`count`

iterate() {
  iter=0
  for a in $amounts; do
    if [[ $iter == 0 ]]; then
      news=$a
    elif [[ $iter == 7 ]]; then # 7, because that is value 6
      ((a+=news))
      printf "$a "
    else
      printf "$a "
    fi
    ((iter++))
  done
  printf "$news "
}

for iter in {1..256}; do
  amounts=`iterate`
done

trimmed=${amounts%% }
echo $(echo ${trimmed// /+} | bc)
