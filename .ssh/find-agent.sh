ssh_find_agent() {
	SOCK=$(ls -t /tmp/ssh-*/agent.* 2> /dev/null | head -1)
	if [ -z "$SOCK" ]; then
		return 1
	fi

	export SSH_AUTH_SOCK=$SOCK
	export SSH_AGENT_PID=$(($(echo "$SSH_AUTH_SOCK" | cut -d. -f2) + 1))
}
