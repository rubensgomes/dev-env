#!/usr/bin/env bash

# File: update.sh
# 
# Description: copies the environment profile files over.
#
# Author: Rubens Gomes

printf "copying ~/.bash_aliases\n"
cp ~/.bash_aliases . || exit 1

printf "copying ~/.bash_profile\n"
cp ~/.bash_profile . || exit 1

printf "copying ~/.bashrc\n"
cp ~/.bashrc . || exit 1

printf "copying ~/.inputrc\n"
cp ~/.inputrc . || exit 1

printf "copying ~/.vimrc\n"
cp ~/.vimrc . || exit 1
