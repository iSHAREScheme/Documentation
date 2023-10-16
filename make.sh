#!/bin/bash

# Command file for Sphinx documentation

sphinx-build -M html . ../

# if ("$SPHINXBUILD" == "") ; then
# 	export SPHINXBUILD=sphinx-build
# fi

# export SOURCEDIR=.
# export BUILDDIR=_build

# if "$1" == "" ; then
# 	goto help
# fi

#%SPHINXBUILD% >NUL 2>NUL
#if errorlevel 9009 (
#	echo.
#	echo.The 'sphinx-build' command was not found. Make sure you have Sphinx
#	echo.installed, then set the SPHINXBUILD environment variable to point3
#	echo.to the full path of the 'sphinx-build' executable. Alternatively you
#	echo.may add the Sphinx directory to PATH.
#	echo.
#	echo.If you don't have Sphinx installed, grab it from
#	echo.http://sphinx-doc.org/
#	exit /b 1
#)

# $SPHINXBUILD -M $1 $SOURCEDIR $BUILDDIR $SPHINXOPTS 
# goto end

# :help
# $SPHINXBUILD -M help $SOURCEDIR $BUILDDIR $SPHINXOPTS 

# :end

