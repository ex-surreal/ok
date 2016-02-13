#!/bin/bash
mkdir -p ~/bin
cat ok.sh > ~/bin/ok
chmod +x ~/bin/ok
if ! [[ ":$PATH:" == *":$HOME/bin:"* ]]; then
    echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bash_profile"
fi
