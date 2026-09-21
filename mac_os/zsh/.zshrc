if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
zstyle ':omz:update' mode auto
zstyle ':omz:update' verbose silent
plugins=(git zsh-autosuggestions zsh-completions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias zshconfig="code ~/.zshrc"
alias zshsource="source ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
alias lg="lazygit"
alias c="clear"
alias rm="rm -rf"
alias ls="ls -lsahG"
alias nr="npm run"
alias nrs="npm run start"
alias nrb="npm run build"
alias nrc="npm run commit"
alias gpup="git push -u"
alias nano='/opt/homebrew/bin/nano'
alias youtube-dl='yt-dlp'

fnm_lazy_load() {
  unset -f fnm node npm npx 2>/dev/null
  eval "$(fnm env)"
}
fnm()  { fnm_lazy_load; fnm "$@"; }
node() { fnm_lazy_load; node "$@"; }
npm()  { fnm_lazy_load; npm "$@"; }
npx()  { fnm_lazy_load; npx "$@"; }

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
pyenv_lazy_load() {
  unset -f pyenv python python3 pip pip3 2>/dev/null
  eval "$(pyenv init -)"
}
pyenv()   { pyenv_lazy_load; pyenv "$@"; }
python()  { pyenv_lazy_load; python "$@"; }
python3() { pyenv_lazy_load; python3 "$@"; }
pip()     { pyenv_lazy_load; pip "$@"; }
pip3()    { pyenv_lazy_load; pip3 "$@"; }

export JAVA_HOME="/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home"
ghidraRun()   { JAVA_HOME="/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home" command ghidraRun "$@"; }
pyghidraRun() { JAVA_HOME="/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home" command pyghidraRun "$@"; }

export PICO_SDK_PATH="$HOME/pico/pico-sdk"
export STM32_PRG_PATH="/Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/STM32CubeProgrammer.app/Contents/MacOs/bin"
export HUMAN_GIT_USER=1
export PATH="$HOME/.local/bin:$PATH"
