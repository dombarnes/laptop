export EDITOR='atom'
# Set $ATOM_PATH
if [[ -d "$HOME/Applications/Atom.app" ]]; then
  export ATOM_PATH="$HOME/Applications"
elif [[ -d "/Applications/Atom.app" ]]; then
  export ATOM_PATH="/Applications"
fi

export PGDATA="/usr/local/var/postgres"
export BOTO_CONFIG="$HOME/.boto"

if [[ -f "$HOME/.env.local" ]]; then
  source $HOME/.env.local
fi  
