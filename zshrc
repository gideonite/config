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
export PATH=~/anaconda3/bin:/Library/TeX/texbin:~/.rbenv/bin:/usr/local/share/npm/bin/:~/bin:~/go/bin:$PLY_HOME/bin:/usr/local/share/python:/usr/local/bin:/usr/local/sbin:$PATH

typeset -U PATH

# Latex
export PATH=/usr/texbin:$PATH

#if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export IDEA_JDK=/usr/local/src/jdk1.7.0_45

# Stupid gulp thing.
ulimit -S -n 2048

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
#{{{ cBioPortal
export PORTAL_HOME=~/dev/cbio-portal
export CGDS_HOME=~/dev/cbio-portal/portal
export CGDS_DATA_HOME=~/dev/cbio-portal/portal
export PORTAL_DATA_HOME=~/dev/cbio-portal/portal-data
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
#zle -N predict-off;
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
bindkey -e                       # Use emacs bindings
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
#alias pip='nocorrect pip'
alias ipython='nocorrect ipython'
alias locate='locate -i'            # always want to ignore case.
alias prettyjson='python -m json.tool'
alias dotperl='rsync -av lib/* ~/.perl/'
alias downloads='cd ~/Downloads && ls -lt | head -n 5'
alias mvdownload="ls -t /tmp/downloads | head -n1 | sed -e 's/\n/\0/' | xargs -I{} cp /tmp/downloads/{}" # takes the latest downloaded file and moves it.
alias i3lock='i3lock -c 000000'
#alias octave='octave --no-gui'
alias mergepdf='gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=merged.pdf'
# git alias
alias gst='git status'
alias gd='git diff'
alias gdl='git diff --name-only'
alias gch='git checkout'
alias glg='git lg'

# os x pdf reader
alias skim='open -a skim'

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
function hal_port_forwarding {
    PORT=$1
    HAL_HOSTNAME=$2
    ssh -v -L $PORT\:localhost:$PORT dresdnerg@hal.cbio.mskcc.org ssh -L $PORT\:localhost:$PORT -N dresdnerg@$HAL_HOSTNAME
}
alias nikola='ssh gmd87@nikola-compute01.coecis.cornell.edu'
alias nikola1='ssh gmd87@nikola-compute01.coecis.cornell.edu'
alias nikola2='ssh gmd87@nikola-compute02.coecis.cornell.edu'
alias nikola3='ssh gmd87@nikola-compute03.coecis.cornell.edu'
alias nik1f='ssh -L 8080:localhost:8080 gmd87@nikola-compute01.coecis.cornell.edu'
alias pex2='ssh dresdnerg@pex2.inf.ethz.ch'
alias eth='sudo openconnect https://sslvpn.ethz.ch -u dgideon'
alias cornell='openconnect https://cuvpn.cuvpn.cornell.edu -u gmd87'
alias usa='sshuttle -r gideon@mookmo.net 0.0.0.0/0 -vv'

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
# deadline counter {{{
function deadline_counter {
    DEADLINE_DAY=`date -d $1 +%j`
    TODAY=`date +%j`
    DAYS_LEFT=$(($DEADLINE_DAY - $TODAY))

    echo
    echo $2: $DAYS_LEFT "DAYS"
}

#deadline_counter "May 20" "NIPS DEADLINE IN"
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
#{{{ leomed cluster
alias bjobs='ssh lm bjobs'
alias bpeek='ssh lm bpeek'
#}}}

[[ $EMACS = t ]] && unsetopt zle

# OPAM configuration
. /home/gideon/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

#{{{ fzf

c() {
	local cols sep
	cols=$(( COLUMNS / 3 ))
	sep='{{::}}'

	# Copy History DB to circumvent the lock
	# - See http://stackoverflow.com/questions/8936878 for the file path
	cp -f ~/Library/Application\ Support/Google/Chrome/Default/History /tmp/h

	sqlite3 -separator $sep /tmp/h \
		"select substr(title, 1, $cols), url
	from urls order by last_visit_time desc" |
	awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\n", $1, $2}' |
	fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs open
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_CTRL_T_OPTS="--bind=ctrl-d:preview-page-down,ctrl-u:preview-page-up --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_R_OPTS="--height 10"
zle     -N   fzf-file-widget
bindkey '^F' fzf-file-widget
fzf-history-widget-accept() {
  fzf-history-widget
  #zle accept-line # run's the command without another <CR>
}
zle     -N     fzf-history-widget-accept
bindkey '^R' fzf-history-widget-accept
export FZF_DEFAULT_COMMAND='rg --files -g ""'

# GIT heart FZF
# -------------

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --height 50% "$@" --border
}

gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -'$LINES
}

gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-git-helper() {
  local c
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}
bind-git-helper f b t r h
unset -f bind-git-helper
#}}}

# must be at end of file
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# itermplot
export MPLBACKEND="module://itermplot"
export ITERMPLOT=rv
