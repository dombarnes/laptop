alias reload!='. ~/.bash_profile'

# Rails
alias migrate="rake db:migrate db:rollback && rake db:migrate db:test:prepare"

alias slogger="~/projects/Slogger/slogger"
alias cdsales="cd ~/DropBox/Public/statusboard_data/Salesboard/"
alias salesup="ruby ~/Dropbox/Public/statusboard_data/Salesboard/salesboard.rb"
alias supe="ruby ~/scripts/supe.rb"
alias insta="ruby ~/scripts/insta.rb"
alias gitweb="git instaweb -d webrick --start"
alias ll="ls -lahG"
alias fuck='sudo $(history -p \!\!)'
alias unhide='defaults write com.apple.finder AppleShowAllFiles YES && killall Finder'
alias rehide='defaults write com.apple.finder AppleShowAllFiles NO'

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'
alias r=bin/rails
alias hl='heroku local'

# Include custom aliases
[[ -f ~/.aliases.local ]] && source ~/.aliases.local
