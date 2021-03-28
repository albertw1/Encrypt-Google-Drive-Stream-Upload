#!/bin/bash
# Written for Ubuntu and Mac OS.

# Inputs
file_name="$1"

gpg -o - --decrypt "${file_name}" | tar -xvf -