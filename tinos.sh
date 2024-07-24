#!/bin/sh

mkdir -p log
fn=log/${HOST}

parallel -j1 --eta --joblog ${fn}.1.joblog --resume --header : \
	build/chase -c 536870912 -i 1 -e 100 -o dfatool -n map {cpu}:{ram} \
	::: cpu $(seq 0 1) \
	::: ram $(seq 0 1) \
>> ${fn}.txt

parallel -j1 --eta --joblog ${fn}.2.joblog --resume --header : \
	build/chase -c 536870912 -i 1 -e 100 -o dfatool -n map {cpu}:{ram} -a forward {stride} \
	::: cpu $(seq 0 1) \
	::: ram $(seq 0 1) \
	::: stride 1 2 4 8 16 32 64 \
>> ${fn}.txt
