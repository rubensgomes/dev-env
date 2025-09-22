#!/usr/bin/env bash

# File: update.sh
# 
# Description: copies the environment profile files over.
#
# Author: Rubens Gomes

cp ~/.bash_aliases . || exit 1
cp ~/.bash_profile . || exit 1
cp ~/.bashrc . || exit 1
cp ~/.inputrc . || exit 1
cp ~/.vimrc . || exit 1
