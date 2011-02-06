. /etc/profile
if [ -e $HOME/.bash_profile ]; then
	. $HOME/.bash_profile
else
    if [ -e $HOME/.bash_login ]; then
        . $HOME/.bash_login
    else
        if [ -e $HOME/.profile ]; then
			. $HOME/.profile
        fi
    fi
fi
echo "---BEGIN-PRINTENV---"
printenv