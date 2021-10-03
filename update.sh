#!/bin/bash

DATETIME=$(date +"%d.%m.%Y-%T")

git add .
git commit -m "update docs ($DATETIME)"
git push
