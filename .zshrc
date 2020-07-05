
autoload -U add-zsh-hook

# enable option arrow navigation for iterm
bindkey "\e\e[D" backward-word
bindkey "\e\e[C" forward-word

# Path to your oh-my-zsh installation.
export ZSH="/Users/yoshi/.oh-my-zsh"
DEFAULT_USER=`whoami`

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster-emoji"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(bundler chucknorris common-aliases gem git web-search yarn )

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Always name 
precmd() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}


# Random fortune through a random cowsay animal, colorized with lolcat
ANIMALS=(beavis.zen blowfish bong bud-frogs bunny cheese cower daemon default dragon
 dragon-and-cow elephant elephant-in-snake eyes flaming-sheep ghostbusters
 head-in hellokitty kiss kitty koala kosh luke-koala meow milk moofasa moose
 mutilated ren satanic sheep skeleton small sodomized stegosaurus stimpy
 supermilker surgery telebears three-eyes turkey turtle tux udder vader
 vader-koala www)
RANDOM_ANIMAL=$ANIMALS[$RANDOM%$#ANIMALS+1]
random_cowsay() {
  fortune | cowsay -f "$RANDOM_ANIMAL" | lolcat 
}

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias zshconfig="vi ~/.zshrc"
alias picSwap="osascript ~/.iterm/iterm2-random-background.scpt"

alias gs="git status"
ghc() {
  gh pr checkout $1
}

# Yarn alias
findPkg() {
  # search installed npm packages
  yarn list --depth 0 | grep $1
}
findScript() {
  # search npm scripts
  yarn run | grep $1
}

# postgres
alias startPG="pg_ctl -D /usr/local/var/postgres start"

# v3 alias
alias startWorkers="bundle exec sidekiq -r ./config/sidekiq.rb -C ./config/sidekiq.yml"
alias resetAB="bundle exec rake ab_decision:reset"
alias migrateDB="bin/rake db:migrate RAILS_ENV=development"
alias cleanTranslations="rm -rf apps/web/lang/build apps/web/lang/messages && yarn webpack"

# rails
alias rake='noglob rake' # always escape square brackets

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# If .nvmrc exists in directory, switch to that node version
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# android nonsense
export PATH=$PATH:~/Library/Android/sdk/platform-tools/
export ANDROID_SDK_ROOT=/Users/yoshi/Library/Android/sdk
alias era="adb reverse tcp:9090 tcp:9090"
alias installCA="cd android && ./gradlew clean installStaging_debug && cd .."
alias installA="cd android && ./gradlew installStaging_debug && cd .."
alias androidEmu="$ANDROID_HOME/emulator/emulator @PIXEL_2_API_28"

export PATH="/usr/local/sbin:$PATH"
