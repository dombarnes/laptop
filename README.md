# Dotfiles

Everyone loves dotfiles. These are mine. They are heavily inspired by [@Holman](https://github.com/holman/dotfiles) and [@thoughtbot](https://github.com/thoughtbot/laptop).  

## Instructions
````
git clone
cd
````
Link your files to dotfiles like this:  
````
$ ln -s laptop/bash_profile ~/.bash_profile
````
and do this for the rest of the files you wanna use.

Then:
````
$ touch ~/.env.local
````
and put in your environment varibles like
````
export AWS_ACCESS_KEY=some_key
export AWS_SECRET_KEY=some_secret
````
Or setup soemthing like 
````
~/.gitconfig.local
````
or
````
~/.aliases.local
````
for stuff thats private.  

## What does it do?
Keeps all useful stuff in sync, like bash_profile, ruby/rails configs, Homebrew stuff, git stuff, pow, Postgres, Atom, etc.

## TODO

1. Make a working installer
