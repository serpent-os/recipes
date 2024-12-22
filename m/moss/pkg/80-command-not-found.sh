command_not_found_handle() {
    local pkgs cmd=$1
    local FUNCNEST=10

    pkg=`NO_COLOR=1 moss info binary\($cmd\) 2>&1`
    if [[ $? -eq 0 ]]; then
    	pkg=$(echo "$pkg" | head -n1 | awk {'print $2'})
    	local r
    	read -r -p "Install package '$pkg'? [Y/n] " r
    	if [[ $r == Y || $r == y ]]; then
    		echo "sudo moss install 'binary($cmd)'"
    		sudo moss install "$pkg"
    		return
    	else
    		return 0
    	fi
    fi

    printf "bash: %s: command not found\n" $cmd >&2

    return 127
}
