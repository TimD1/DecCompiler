#!/bin/bash

file="$1"
slash="/"
file=$PWD$slash$file

# ensure numbers in comments don't mess up our comments
sed -i -e 's/0/zero/g' $file
sed -i -e 's/1/one/g' $file

# replace all brainfuck operators with new operators
sed -i -e 's/{/0/g' $file
sed -i -e 's/}/1/g' $file
sed -i -e 's/>/2/g' $file
sed -i -e 's/</3/g' $file
sed -i -e 's/+/4/g' $file
sed -i -e 's/-/5/g' $file
sed -i -e 's/\./6/g' $file
sed -i -e 's/,/7/g' $file
sed -i -e 's/\[/8/g' $file
sed -i -e 's/\]/9/g' $file
