#!/bin/bash --login

# Taken from: https://gist.github.com/claybridges/cea5d4afd24eda268164#file-xcbuild-safe-sh
# TL;DR: Since Xcode 7, command line tools have a dependency on system Ruby, because reasons of course.
# This script switch the Ruby version for the scope on only this command

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
rvm use system

unset RUBYLIB
unset RUBYOPT
unset BUNDLE_BIN_PATH
unset _ORIGINAL_GEM_PATH
unset BUNDLE_GEMFILE

set -x
xcrun "$@"