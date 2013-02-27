if [ "$PS1" ]; then
    shopt -s checkwinsize
    if [[ -f /.dcinfo ]]; then
        . /.dcinfo
        DC_NAME="${SDC_DATACENTER_NAME}"
    fi
    if [[ -n "${DC_NAME}" ]]; then
       PS1="[\u@\h (${DC_NAME}) \w]\\$ "
    else
       PS1="[\u@\h \w]\\$ "
    fi
    alias ll='ls -lF'
    alias ls='ls --color=auto'
    [ -n "${SSH_CLIENT}" ] && export PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME} \007" && history -a'
fi

# Load bash completion
[ -f /etc/bash/bash_completion ] && . /etc/bash/bash_completion

case "$TERM" in
	screen)
		export TERM=xterm-color
		;;
	screen-256color)
		export TERM=xterm-color
		;;
esac

svclog() {
  if [[ -z "$PAGER" ]]; then
    PAGER=less
  fi
  $PAGER `svcs -L $1`
}

svclogf() {
  /usr/bin/tail -f `svcs -L $1`
}
