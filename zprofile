if command -v keychain &> /dev/null && [[ -f "$HOME/.ssh/id_rsa" ]]; then
  keychain "$HOME/.ssh/id_rsa"
  source "$HOME/.keychain/$(hostname)-sh" > /dev/null
fi



if [ $(uname) = Darwin ]; then
    eval $(/opt/homebrew/bin/brew shellenv)
fi

