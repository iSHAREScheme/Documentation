#!/bin/bash

git switch DevPortalchristiaan
git pull

sphinx-build -M html . ../
