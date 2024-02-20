#!/bin/bash

: '
********************
Author: Vipin Kumar
********************
entrypoint.sh
'

/reviewer-auto-assignment.sh "$1" "$2"
pushd /
which python3
python3 --version
python3 -m venv .venv
source .venv/bin/activate
pip3 install --upgrade pip
pip install pip-tools
pip-compile -q
pip-sync -q
python3 reviewer-auto-assignment.py "$1" "$2"

echo "message=Reviewers assinged to the Pull Requests." >> $GITHUB_OUTPUT
