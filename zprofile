# Turn on keychain
if which keychain>/dev/null; then
  keychain ~/.ssh/id_rsa
  source ~/.keychain/$(hostname)-sh > /dev/null
fi

export PATH="$HOME/.cargo/bin:$PATH"


if [ $(uname) = Darwin ]; then
    eval $(/opt/homebrew/bin/brew shellenv)
fi

