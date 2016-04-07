if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

if [[ -a ~/.localrc ]]; then
  source ~/.localrc
fi

for f in $HOME/laptop/*.bash; do
	 . $f
done

export PATH="$HOME/laptop/bin:$PATH"

# Travis needs this
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh
# For asp.net tools
[ -s "/Users/domster83/.dnx/dnvm/dnvm.sh" ] && source "/Users/domster83/.dnx/dnvm/dnvm.sh" # Load dnvm
# The next line updates PATH for the Google Cloud SDK.
source '/usr/local/google-cloud-sdk/path.bash.inc'
# The next line enables shell command completion for gcloud.
source '/usr/local/google-cloud-sdk/completion.bash.inc'

# Set git autocompletion and PS1 integration
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

GIT_PS1_SHOWDIRTYSTATE=true

if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

if which rbenv > /dev/null; then
	eval "$(rbenv init -)";
fi

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "(${BRANCH}${STAT})"
	else
		echo ""
	fi
}
# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

# A nice bash prompt
PS1="\[\033[0;36m\]\w\[\033[31m\]\$(parse_git_branch) \u $ \[\e[0m\]"

# Print working directory after a cd.
cd() {
    if [[ $@ == '-' ]]; then
        builtin cd "$@" > /dev/null  # We'll handle pwd.
    else
        builtin cd "$@"
    fi
    echo -e "   \033[32m"`pwd`"\033[0m"
    # print the current ruby version if set
    if [ -f ".ruby-version" ]; then
    	var=$(rbenv version|awk '{print $1}')
    	echo -e "   \033[32m"rbenv $var
    fi
}

# Remote Mount (sshfs)
# creates mount folder and mounts the remote filesystem
rmount() {
	local host folder mname
	host="${1%%:*}:"
	[[ ${1%:} == ${host%%:*} ]] && folder='' || folder=${1##*:}
	if [[ $2 ]]; then
		mname=$2
	else
		mname=${folder##*/}
		[[ "$mname" == "" ]] && mname=${host%%:*}
	fi
	if [[ $(grep -i "host ${host%%:*}" ~/.ssh/config) != '' ]]; then
		mkdir -p ~/mounts/$mname > /dev/null
		sshfs $host$folder ~/mounts/$mname -oauto_cache,reconnect,defer_permissions,negative_vncache,volname=$mname,noappledouble && echo "mounted ~/mounts/$mname"
	else
		echo "No entry found for ${host%%:*}"
		return 1
	fi
}

# Remote Umount, unmounts and deletes local folder (experimental, watch you step)
rumount() {
	if [[ $1 == "-a" ]]; then
		ls -1 ~/mounts/|while read dir
		do
			[[ $(mount|grep "mounts/$dir") ]] && umount ~/mounts/$dir
			[[ $(ls ~/mounts/$dir) ]] || rm -rf ~/mounts/$dir
		done
	else
		[[ $(mount|grep "mounts/$1") ]] && umount ~/mounts/$1
		[[ $(ls ~/mounts/$1) ]] || rm -rf ~/mounts/$1
	fi
}
rbenv rehash 2>/dev/null

rbenv() {
  typeset command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval `rbenv "sh-$command" "$@"`;;
  *)
    command rbenv "$command" "$@";;
  esac
}

code () {
    if [[ $# = 0 ]]
    then
        open -a "Visual Studio Code"
    else
        [[ $1 = /* ]] && F="$1" || F="$PWD/${1#./}"
        open -a "Visual Studio Code" --args "$F"
    fi
}

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh
