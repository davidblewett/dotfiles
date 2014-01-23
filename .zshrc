UNAME=$(uname)
source $HOME/.commonfuncs
source ~/bin/tmuxinator.zsh
# Common hashes
hash -d L=/var/log
hash -d R=/usr/local/etc/rc.d

# OS X specific settings
if [ $UNAME = "Darwin" ]; then
    
    # set up dir hashes
    hash -d P=$HOME/sixfeetup/projects
    hash -d S=$HOME/Sites

fi

# set up common aliases between shells
source $HOME/.commonrc

# global aliases
################
# disable the plonesite part in a buildout run, example: $ bin/buildout -N psef
alias -g psef="plonesite:enabled=false"
# get the site packages for your python, example: $ cd $(python2.5 site-packages)
alias -g site_packages='-c "from distutils.sysconfig import get_python_lib; print get_python_lib()"'
# some pipes
alias -g G='| grep'
alias -g L='| less'
alias -g M='| more'
alias -g T='| tail'
alias -g TT='| tail -n20'
if checkPath colordiff; then
    alias -g CD='| colordiff'
else
    alias -g CD='| vim -R -'
fi
# bootstrap with distribute
#alias -g bootstrap='bootstrap.py --distribute'

# turn off the stupid bell
setopt NO_BEEP

# automatically print timing statistics if the command took longer
# than a minute
export REPORTTIME=60

# Changing Directories
setopt AUTO_CD CDABLE_VARS
# automatically save recent directories on the stack
setopt AUTO_PUSHD
setopt PUSHDMINUS
setopt PUSHD_IGNORE_DUPS

# globbing
setopt GLOB_DOTS

# History
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt EXTENDED_HISTORY

# Look for a command that started like the one starting on the command line.
# taken from: http://www.xsteve.at/prg/zsh/.zshrc (not sure of original source)
function history-search-end {
    integer ocursor=$CURSOR

    if [[ $LASTWIDGET = history-beginning-search-*-end ]]; then
      # Last widget called set $hbs_pos.
      CURSOR=$hbs_pos
    else
      hbs_pos=$CURSOR
    fi

    if zle .${WIDGET%-end}; then
      # success, go to end of line
      zle .end-of-line
    else
      # failure, restore position
      CURSOR=$ocursor
      return 1
    fi
}

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# set up the history-complete-older and newer
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# vi command line editor
########################
# TODO: Un-comment the following line to have vi style keybindings
bindkey -v
# use home and end to go to end and beginning of the line
bindkey -M viins '^A' vi-beginning-of-line
bindkey -M viins '^E' vi-end-of-line
bindkey -M viins '^[[H' vi-beginning-of-line
bindkey -M viins '^[[F' vi-end-of-line
# use ctrl+a and ctrl+e like emacs mode
bindkey -M viins '^A' vi-beginning-of-line
bindkey -M viins '^E' vi-end-of-line
# use delete as forward delete
bindkey -M viins '\e[3~' vi-delete-char
# line buffer
bindkey -M viins '^B' push-line-or-edit
# change the shortcut for expand alias
bindkey -M viins '^X' _expand_alias
# Search backwards with a pattern
bindkey -M vicmd '^R' history-incremental-pattern-search-backward
bindkey -M vicmd '^F' history-incremental-pattern-search-forward
# set up for insert mode too
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^F' history-incremental-pattern-search-forward
# complete previous occurences of the command up till now on the command line
bindkey -M viins "^[OA" history-beginning-search-backward-end
bindkey -M viins "^[[A" history-beginning-search-backward-end
bindkey -M viins "^N" up-line-or-search
bindkey -M viins "^[OB" history-beginning-search-forward-end
bindkey -M viins "^[[B" history-beginning-search-forward-end
bindkey -M viins "^P" down-line-or-search

#ZKBD Settings
##############
if [ -f ~/.zkbd/$TERM-$VENDOR-$OSTYPE ]; then
  source ~/.zkbd/$TERM-$VENDOR-$OSTYPE
  [[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
  [[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
  [[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" up-line-or-history
  [[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
  [[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
  [[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" down-line-or-history
  [[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
  [[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
  [[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search
  [[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char 
fi

# edit current command in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# History settings
##################
HISTSIZE=3000
SAVEHIST=3000
HISTFILE=~/.zsh_history
export HISTFILE HISTSIZE SAVEHIST

# Completions
#############
autoload -U compinit
compinit -C
# case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# uncomment this to show when you aren't the current user
ME="davidb"

# use some crazy ass shell prompt
# thanks to for the basis: http://aperiodic.net/phil/prompt/
#source $HOME/.zshprompt

# use a simpler 3 line prompt
source $HOME/.zshprompt_simple

# load up per environment extras
source ~/.zshextras

#Setup keys from terminfo
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
#typeset -A key

#key[Home]=${terminfo[khome]}
#key[End]=${terminfo[kend]}
#key[Insert]=${terminfo[kich1]}
#key[Delete]=${terminfo[kdch1]}
#key[Up]=${terminfo[kcuu1]}
#key[Down]=${terminfo[kcud1]}
#key[Left]=${terminfo[kcub1]}
#key[Right]=${terminfo[kcuf1]}
#key[PageUp]=${terminfo[kpp]}
#key[PageDown]=${terminfo[knp]}

#for k in ${(k)key} ; do
#    # $terminfo[] entries are weird in ncurses application mode...
#    [[ ${key[$k]} == $'\eO'* ]] && key[$k]=${key[$k]/O/[}
#done
#unset k

# setup key accordingly
#[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
#[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
#[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
#[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
#[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
#[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
#[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
#[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# borrowed from https://github.com/rampion/rc-files
# if using GNU screen, let the zsh tell screen what the title and hardstatus
# of the tab window should be.
if [[ $TERM == "screen" ]]; then
        # use the current user as the prefix of the current tab title (since that's
        # fairly important, and I change it fairly often)
  TAB_TITLE_PREFIX='"${USER}$PROMPT_CHAR"'
        # when at the shell prompt, show a truncated version of the current path (with
        # standard ~ replacement) as the rest of the title.
        TAB_TITLE_PROMPT='`echo $PWD | sed "s/^\/Users\//~/;s/^~$USER/~/;s/\/..*\//\/...\//"`'
        # when running a command, show the title of the command as the rest of the
        # title (truncate to drop the path to the command)
        TAB_TITLE_EXEC='$cmd[1]:t'

        # use the current path (with standard ~ replacement) in square brackets as the
        # prefix of the tab window hardstatus.
        TAB_HARDSTATUS_PREFIX='"[`echo $PWD | sed "s/^\/Users\//~/;s/^~$USER/~/"`] "'
        # when at the shell prompt, use the shell name (truncated to remove the path to
        # the shell) as the rest of the title
        TAB_HARDSTATUS_PROMPT='$SHELL:t'
        # when running a command, show the command name and arguments as the rest of
        # the title
        TAB_HARDSTATUS_EXEC='$cmd'

        # tell GNU screen what the tab window title ($1) and the hardstatus($2) should be
  function screen_set()
  {
                #        set the tab window title (%t) for screen
                print -nR $'\033k'$1$'\033'\\\

                # set hardstatus of tab window (%h) for screen
                print -nR $'\033]0;'$2$'\a'
  }
        # called by zsh before executing a command
  function preexec()
  {
                local -a cmd; cmd=(${(z)1}) # the command string
                eval "tab_title=$TAB_TITLE_PREFIX$TAB_TITLE_EXEC"
                eval "tab_hardstatus=$TAB_HARDSTATUS_PREFIX$TAB_HARDSTATUS_EXEC"
                screen_set $tab_title $tab_hardstatus
  }
        # called by zsh before showing the prompt
  function precmd()
  {
                eval "tab_title=$TAB_TITLE_PREFIX$TAB_TITLE_PROMPT"
                eval "tab_hardstatus=$TAB_HARDSTATUS_PREFIX$TAB_HARDSTATUS_PROMPT"
                screen_set $tab_title $tab_hardstatus
  }
fi
