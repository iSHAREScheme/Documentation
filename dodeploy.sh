#!/bin/bash

git git branch --set-upstream-to=origin/DevPortalchristiaan
git pull

sphinx-build -M html . ../
