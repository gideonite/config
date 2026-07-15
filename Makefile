DEST = $(HOME)

# Dotfiles, as they appear in the repo. Each one will be linked to the
# filename you get by prefixing "~/.".
CONFIGS = \
Xdefaults \
Xmodmap \
config/awesome/rc.lua \
config/ghostty/config \
gitconfig \
screenrc \
tmux.conf \
vim \
vimrc \
zprofile \
zsh \
zshenv \
zshprompt \
zshrc \
ackrc \
hgrc

# The names of the pathogen bundles we want to install. These are kept as
# submodules in vim/bundle/, and are updated when we install.
PATHOGENBUNDLENAMES = $(shell git submodule status | cut -d' ' -f3 | grep vim | cut -d'/' -f3)

ZSHBUNDLEFILES =

TARGETS = $(patsubst %,$(DEST)/.%,$(CONFIGS))

# Add bin/hub etc
TARGETS += $(DEST)/bin/hub

PATHOGENBUNDLES= $(patsubst %,vim/bundle/%/.git,$(PATHOGENBUNDLENAMES))
ZSHBUNDLES = $(patsubst %,zsh/func/%/.git,$(ZSHBUNDLEFILES))

all: build

install: build $(TARGETS) $(DEST)/.codex/AGENTS.md $(DEST)/.claude/CLAUDE.md $(DEST)/.config/agents/AGENTS.local.md

# Shared, agent-agnostic instructions. agents/AGENTS.md is the single
# source of truth; it is symlinked only into each tool's own global
# config location, so nothing lands directly in the home directory.
#
# - ~/.codex/AGENTS.md   : Codex's global instructions
# - ~/.claude/CLAUDE.md  : Claude Code's global instructions
$(DEST)/.codex/AGENTS.md: agents/AGENTS.md
	@mkdir -p $(dir $@)
	@[ ! -e $@ ] || [ -h $@ ] || mv -f $@ $@.bak
	ln -sf $(PWD)/agents/AGENTS.md $@

$(DEST)/.claude/CLAUDE.md: agents/AGENTS.md
	@mkdir -p $(dir $@)
	@[ ! -e $@ ] || [ -h $@ ] || mv -f $@ $@.bak
	ln -sf $(PWD)/agents/AGENTS.md $@

# Per-machine instructions, imported by AGENTS.md. Created empty when
# absent and never overwritten, so each machine keeps its own overrides.
$(DEST)/.config/agents/AGENTS.local.md:
	@mkdir -p $(dir $@)
	touch $@

$(DEST)/.% : %
	@mkdir -p $(dir $@)
	@[ ! -e $@ ] || [ -h $@ ] || mv -f $@ $@.bak
	ln -sf $(PWD)/$* $@

$(DEST)/.%/:
	mkdir -p $@

$(DEST)/% : %
	@mkdir -p $(dir $@)
	@[ ! -e $@ ] || [ -h $@ ] || mv -f $@ $@.bak
	ln -sf $(PWD)/$* $@

bin/hub:
	mkdir -p bin
	curl http://defunkt.io/hub/standalone -sLo bin/hub && chmod +x bin/hub

vim/bundle/%/.git:
	git submodule update --init --recursive $(patsubst %/.git,%,$@)

zsh/func/%/.git:
	git submodule update --init --recursive $(patsubst %/.git,%,$@)

build: bundles bin/hub

bundles: $(PATHOGENBUNDLES) $(ZSHBUNDLES)

clean:
	@echo Cleaning from $(DEST)
	rm -f $(TARGETS)

.PHONY: build install clean
