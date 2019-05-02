#!/bin/sh

#DIR=$(dirname "$0")

#cd $DIR/..

if [[ $(git status -s) ]]
then
    echo "the working directory is dirty. please commit any pending changes."
    exit 1;
fi

echo "deleting old publication"
rm -rf public
mkdir public
git worktree prune
rm -rf .git/worktrees/public/

echo "checking out master branch into public"
git worktree add -B gh-pages public origin/master

echo "removing public folder"
rm -rf public/*

echo "generating site"
HUGO_ENV="production" hugo

echo "updating gh-pages branch"
cd public && git add --all && git commit -m "publishing to master"

echo "pushing to origin master"
git push origin master -f