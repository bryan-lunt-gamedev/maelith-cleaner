#!/usr/bin/env bash

###Snippet from http://stackoverflow.com/questions/59895/
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
###end snippet


( cd ${SCRIPT_DIR} && docker build -t maelith-cleaner docker/ )

