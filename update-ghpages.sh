#!/bin/bash

# causes the shell to exit if any subcommand or pipeline returns a non-zero status
set -e

# Clone gh-pages
git clone -b gh-pages "https://${GH_REF}" ghpagesclone
cd ghpagesclone

# Init and update submodule to latest
git submodule update --init --recursive
git submodule update --remote

# Setup Git
git config user.name "chennanni"
git config user.email "chennancd@gmail.com"

# If there is a new version of the master branch
if git status | grep archive > /dev/null 2>&1
then
  # it should be committed
  git add .
  git commit -m ":sunny: Automagic Update via Travis-CI"
  git push --quiet "https://${GH_TOKEN}:x-oauth-basic@${GH_REF}" gh-pages > /dev/null 2>&1
fi

# Credit: https://github.com/iluwatar/java-design-patterns/blob/master/.travis.yml
