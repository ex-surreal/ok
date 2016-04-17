#!/bin/bash
mkdir -p $HOME/bin
cat ok.sh > $HOME/bin/ok
chmod +x $HOME/bin/ok
if [ -f $HOME/.bash_profile ]; then
    source $HOME/.bash_profile
fi
if ! [[ ":$PATH:" == *":$HOME/bin:"* ]]; then
    echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bash_profile" && echo 'PATH updated'
fi
