#!/bin/sh -l

: '
********************
Author: Vipin Kumar
********************
entrypoint.sh
'

./reviewer-auto-assignment.sh "$1" "$2"

which python3
python3 -m venv .venv
source .venv/bin/activate
pip3 install --upgrade pip
pip install pip-tools
pip-compile
pip-sync
python3 reviewer-auto-assignment.py "$1" "$2"

echo "message=Reviewers assinged to the Pull Requests." >> $GITHUB_OUTPUT
