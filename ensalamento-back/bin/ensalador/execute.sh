#!/bin/bash


./ensalador open || return 1

echo "CT"
./ensalador exec "{day: [2,3,4,5,6,7], block: [ct]}"

echo "EQ"
./ensalador exec "{day: [2,3,4,5,6,7], block: [eq]}"

echo "PD"
./ensalador exec "{day: [2,3,4,5,6,7], block: [pd]}"

echo "PK PL"
./ensalador exec "{day: [2,3,4,5,6,7], block: [pk,pl]}"

echo "PQ"
./ensalador exec "{day: [2,3,4,5,6,7], block: [pq]}"

echo "PF"
./ensalador exec "{day: [2,3,4,5,6,7], block: [pf]}"

echo "PH"
./ensalador exec "{day: [2,3,4,5,6,7], block: [ph]}"


./ensalador exec "{day: [2,3,4,5,6,7]}"


./ensalador close

./Relacoes.sh output.txt

