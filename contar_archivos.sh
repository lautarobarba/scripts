#!/bin/bash

find . -type d -exec bash -c 'echo -n "{}: "; find "{}" -type f | wc -l' \;
