#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
#
#
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.dotnet" ] ; then
    PATH="$PATH:$HOME/.dotnet"
fi

if [ -d "$HOME/scripts" ] ; then
    PATH="$PATH:$HOME/scripts"
fi
