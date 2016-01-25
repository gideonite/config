# .zshrc by Jordan Lewis and Gideon Dresdner.

# Startup {{{

# Start X immediately at login.
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

# }}}
# Environment variables {{{
HISTFILE=~/.zshhistory            # What histfile are we using?
HISTSIZE=100000                   # Big = better
SAVEHIST=7000                     # When to save to the file?
export SHELL=`which zsh`                 # New shells don't open bash
export EDITOR=vim                        # Use vim!
export GOROOT=$HOME/go
export GOOS=darwin
export GOARCH=amd64
if [ $(uname) = Linux ]; then 
    alias ls='ls --color=auto'
else
    export CLICOLOR=1
fi
export NNTPSERVER=news-server.nyc.rr.com # Use my ISP's news server
export PERL5LIB='/Users/jlewis/.perl/'
export PLY_HOME=~/ext/ply/dist/ply
export PATH=~/.gem/ruby/2.1.0/bin:/usr/local/share/npm/bin/:~/bin:~/go/bin:$PLY_HOME/bin:/usr/local/share/python:/usr/local/bin:/usr/local/sbin:$PATH

typeset -U PATH

# Latex
export PATH=/usr/texbin:$PATH

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export IDEA_JDK=/usr/local/src/jdk1.7.0_45

# Stupid gulp thing.
ulimit -S -n 2048

#{{{ cBioPortal
export PORTAL_HOME=~/dev/cbio-portal
export CGDS_HOME=~/dev/cbio-portal/portal
export CGDS_DATA_HOME=~/dev/cbio-portal/portal
export PORTAL_DATA_HOME=~/dev/cbio-portal/portal-data
#}}}
#{{{ perka
#
#Keeping this around just in case I want to go over the config someday.
#
#export WORKSPACE=$HOME/perka
#export ANDROID_HOME=$WORKSPACE/dev/android/android-sdk-macosx
#export MAVEN_OPTS=-Xmx1536M
#export PATH=$WORKSPACE/dev/bin:${M2_HOME}/bin:$ANDROID_HOME/platform-tools:$PATH
##export PATH=/Applications/Xcode.app/Contents/Developer/usr/libexec/git-core/:$PATH
#export PATH=/usr/local/mysql/bin:$PATH
##export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)
#alias fastgulp="gulp gen && gulp -p admin,merchant,profile,validator"
#alias fastmvn="mvn -DskipCassandraTests -DskipDependencyChecks -DskipFindbugs -DskipTests"
#alias build="mvn -DskipCassandraTests -DskipDependencyChecks -DskipFindbugs -DskipTests clean install && notify 'BUILD DONE'"
#alias resumefrom="fastmvn -T 1.5C clean install -rf"
#alias findbugs="mvn -DskipCassandraTests -DskipDependencyChecks -DskipTests"
#alias mvnpl="mvn clean install -pl "
#alias pbs="~/myperka/scripts/pbs.sh"
#alias notify="~/myperka/scripts/notify.sh"
#alias starter="vim ~/.starter.json"
#alias offshards="jq '.[\"jobs\"] | .[] | {\"name\", \"count\":.count} | select(.count < 1) | {\"name\"}' ~/.starter.json | grep -v \"{\" | grep -v \"}\" | awk -F: '{print \$2}'"
#
#export ANDROID_HOME=$HOME/android-sdk-macosx/
#export PATH=$ANDROID_HOME/tools:$PATH
#export PATH=$ANDROID_HOME/platform-tools:$PATH
#
#export M2_HOME=$WORKSPACE/dev/maven    # perka
##export M2_HOME=/usr/local/apache-maven  # rest of the world
#export PATH=$M2_HOME/bin:$PATH
#}}}


# }}}
# Setopts {{{
setopt auto_cd             # If I type a directory, assume I mean to cd to it
setopt auto_pushd          # Automatically push directories onto the stack
setopt badpattern          # Print an error message on badly formed glob
#setopt cdablevars          # So we can cd to metachars like ~
setopt correct             # Attempt typo corrections
setopt complete_in_word    # 
#setopt extended_glob       # Allow ~ # ^ metachars in globbing
# disabled - this makes it so you can't use the ^ revision spec thing with git!
setopt extended_history    # More information in history
setopt hist_ignore_space   # Don't put space-prepended commands in the history
setopt interactivecomments # Allow comments even in the interactive shell
setopt listpacked          # Menucomplete can use different col widths
setopt magicequalsubst     # echo foo=~/bar -> foo/home/jlewis/bar
#setopt markdirs            # Append / to all glob-completed dirs
# disabled - given a dirtree foo/bar/baz.txt, cp -R foo/* /tmp/ causes baz.txt
# to be sent to /tmp/. no good!
setopt multios             # Allow multiple redirection!
setopt nobeep              # Don't beep
setopt no_flowcontrol      # No stupid flow control!
setopt nullglob            # Delete a glob if it doesn't match anything
setopt promptsubst
setopt pushd_ignore_dups   # Don't push multiple copies of a directory
# }}}
# Autoloads {{{
autoload -U compinit; compinit
autoload -U predict-on
autoload -U edit-command-line
autoload -U copy-earlier-word
autoload -U add-zsh-hook
# }}}
# Zle {{{
zle -N predict-on;
zle -N predict-off;
zle -N edit-command-line
zle -N copy-earlier-word
# }}}
# Zstyles {{{
zstyle ':completion::complete:*' use-cache 1 # uses completion cache
zstyle ':completion::complete:*' cache-path ~/.zshcache
zstyle ':completion:*' menu select # menu-style completion
zstyle ':completion:*:functions' ignored-patterns '_*' # no missing completions
# }}}
# Bindkeys {{{
bindkey -v                       # Use vim bindings
bindkey "^A" beginning-of-line   # Like in bash, for memory
bindkey "^B" beginning-of-line   # This won't be screwed up by screen, but weird
bindkey "^E" end-of-line         # Like in bash
bindkey "^N" accept-and-infer-next-history # Enter; pop next history event
bindkey "^O" push-line           # Pushes line to buffer stack
bindkey "^P" get-line            # Pops top of buffer stack
bindkey "^R" history-incremental-search-backward # Like in bash, but should !
bindkey "^T" transpose-chars     # Transposes adjacent chars
bindkey "^Y" copy-earlier-word
bindkey "^Z" accept-and-hold     # Enter and push line
bindkey " " magic-space          # Expands from hist (!vim )
bindkey "^\\" pound-insert       # As an alternative to ctrl-c; will go in hist
bindkey "\e[3~" delete-char      # Enable delete
#bindkey "^Q" predict-off        # Disable sweet complete-as-you-type
#bindkey "..." predict-on         # Enable sweet complete-as-you-type
bindkey '^x^e' edit-command-line # edit commandline in vim

# }}}
# Aliases {{{
# Misc {{{
alias cp='nocorrect cp'        # Don't correct this cmd
alias mkdir='nocorrect mkdir'  # Don't correct this cmd
alias mv='nocorrect mv'        # Don't correct this cmd
alias touch='nocorrect touch'  # Don't correct this cmd
alias git='nocorrect git'
alias sag='nocorrect sag'
alias pstree='nocorrect pstree'
alias hg='nocorrect hg'
alias php='nocorrect php'
alias mongo='nocorrect mongo'
alias cmus='nocorrect cmus'
alias node='nocorrect node'

alias grep='grep --color=auto'          # Color my greps
alias sl='sl -l'               # ... dumb
alias termcast='telnet 213.184.131.118 37331'   # noway.ratry.ru 37331
alias slurp='wget -r --no-parent'
alias deflac='for file in *.flac; do $(flac -cd "$file" | lame -V 0 --vbr-new - "${file%.flac}.mp3"); done'   # convert all flacs in directory to v0
alias heroku='nocorrect heroku'
alias mutt='nocorrect mutt'
alias proj='nocorrect proj'
alias npm='nocorrect npm'
alias valgrind='nocorrect valgrind'
alias racket='nocorrect racket'
alias pip='nocorrect pip'
alias ipython='nocorrect ipython'
alias locate='locate -i'            # always want to ignore case.
alias prettyjson='python -m json.tool'
alias dotperl='rsync -av lib/* ~/.perl/'
alias downloads='cd ~/Downloads && ls -lt | head -n 5'
alias i3lock='i3lock -c 000000'
alias octave='octave --no-gui'

# git alias
alias gst='git status'
alias gd='git diff'
alias gdl='git diff --name-only'
alias gch='git checkout'
alias glg='git lg'

# }}}
# Shells {{{
alias mookmo='ssh gideon@mookmo.net'

alias cbio='ssh dresdnerg@cbio.mskcc.org'
alias saba='ssh dresdnerg@saba.cbio.mskcc.org'
alias misodev='ssh dresdnerg@miso-dev.cbio.mskcc.org'
alias miso='ssh dresdnerg@miso.cbio.mskcc.org'
alias unagi='ssh dresdnerg@unagi.cbio.mskcc.org'
alias cbsu='ssh gmd87@cbsulogin.tc.cornell.edu'
alias hal='ssh dresdnerg@hal.cbio.mskcc.org'

alias ssh_proxy='ssh -C2qTnN -D ' # https://calomel.org/firefox_ssh_proxy.html
# }}}
# Games {{{
alias cao='TERM=rxvt telnet crawl.akrasiac.org' # urxvt-color screws up
alias nao='TERM=rxvt telnet nethack.alt.org'    # urxvt-color screws up
alias sco='TERM=rxvt telnet slashem.crash-override.net'
alias spork='TERM=rxvt telnet sporkhack.nineball.org'
# }}}
# Shortcuts {{{
alias '..'='cd ..'               # cd .. takes too much effort!
alias 'web'='python -m SimpleHTTPServer' # hosts . on :8000
alias bc='bc -q -l'              # no warranty thing; loads math lib
alias broadcast='ifconfig | grep broadcast | tail -c 16'
alias cls='perl -e "print \"\e[2J\""' # prints a clearscreen - for termcast
alias duf='du -sk * | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'
alias hide='xset dpms force standby; exit' # kills my LCD monitor
alias l='ls'                     # sometimes I think I'm still on a MUD/MOO
alias mouse='xmodmap -e "pointer = 1 2 3 6 7 8 9 10 4 5"' # fixes my buttons
alias ncscan='nc -v -z'          # scans ports with netcat
alias nmapscan='nmap -p'         # scans ports with nmap
alias probe='ping -i 50 `ifconfig | grep broadcast | tail -c 16`'
alias reload='source ~/.zshrc'   # re-sources this
alias restartx='sleep 5; startx' # restarts X!
alias tdA="todo -A"              # displays all todo items
alias usage='du -hs *'           # nicely displays disk usage of items in pwd
which htop>/dev/null && alias top='htop' # prettier version of top if it exists
alias agj="ag --ignore target"   # silver searcher that ignores the maven target directory.
alias agjs="ag --ignore-dir perka-client --ignore-dir flatpack"
alias tarcompress="tar -cvzf"
alias tardecompress="tar -xvf"

# sometimes the network-manager needs encouragement
which /etc/init.d/network-manager>/dev/null && alias interet-restart='sudo /etc/init.d/network-manager restart'

alias open='xdg-open'

# passwords
which lpass>/dev/null && alias pwds='lpass show active-passwords'

alias findreplace="perl -pi.bak -e 's/\"//g'"

# }}} 
# Global shortcuts {{{
alias -g ...='../..'             # Ease of going backward
alias -g ....='../../..'         # Yes
alias -g .....='../../../..'     # YES
alias -g G='|egrep'              # cat biglongfile G cheese
alias -g H='|head'               # cat biglongfile H
alias -g L='|less'               # cat biglongfile L
alias -g T='|tail'               # cat biglongfile T
alias -g W='|wc'                 # cat biglongfile W
# }}}
# }}}
# Prompt {{{
source ~/.zshprompt
# }}}
# Functions {{{
aalias() {
    # Grabs the aliased value from within the quotes
    alias $1 | awk -F "'" '{print $2}'
}
# }}}
# fortune {{{
fortune 2>/dev/null #|| return 0 # essential!
# }}}
# {{{ marker

# source: http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
export MARKPATH=$HOME/.marks
function jump {
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark {
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}

function unmark {
    rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

# marks function for mac os
# function marks {
#     \ls -l "$MARKPATH" | tail -n +2 | sed 's/  / /g' | cut -d' ' -f9- | awk -F ' -> ' '{printf "%-10s -> %s\n", $1, $2}'
# }

# tab completion for zsh
function _completemarks {
    reply=($(ls $MARKPATH))
}

compctl -K _completemarks jump
compctl -K _completemarks unmark

alias j='jump'

# }}}

[[ $EMACS = t ]] && unsetopt zle


# OPAM configuration
# . /home/gideon/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
