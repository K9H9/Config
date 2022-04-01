#Loading p10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
#---------------------------------------------------------------------------
#Defining path to oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
#---------------------------------------------------------------------------
#Zsh theme loading
ZSH_THEME="powerlevel10k/powerlevel10k"
#---------------------------------------------------------------------------
#plugin list
plugins=(git autojump web-search thefuck zsh-syntax-highlighting zsh-history-substring-search zsh-autosuggestions)
#---------------------------------------------------------------------------
#Source plugins
#source ~/Code/scripts/vim.sh
source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source $ZSH/oh-my-zsh.sh
source ~/Code/scripts/screen_starter.sh
source ~/Code/scripts/dotfile.sh 
#---------------------------------------------------------------------------
#Aliases
#---------------------------------------------------------------------------
#git push 
alias gp="git push origin master"
#---------------------------------------------------------------------------
#speedtest
alias speed="/home/koho/Apps/speed-ookla/speedtest"
#---------------------------------------------------------------------------
alias config='/usr/bin/git --git-dir=$HOME/Code/Dotfiles --work-tree=$HOME'
alias shut="sudo openrc-shutdown -p now"
alias zs="nvim $HOME/.zshrc"
alias sc="source $HOME/.zshrc"
alias sc1="source $HOME/.p10k.zsh"
alias update="sudo pacman -Syy && sudo pacman -Syu && yay -Syu"
alias cri="cargo init"
alias cb="cargo build"
#Package managing
eval $(keychain --eval --quiet id_rsa ~/.ssh/id_rsa)
#---------------------------------------------------------------------------
S() {
  sudo pacman -S $1
}
rf() {
  rm -d $1
}
R() {
  sudo pacman -R $1
}
#C/C++
#---------------------------------------------------------------------------
cpp() {
   var1=$1 && var2=.x && g++ -std=c++17 -O2 -Wall $1 -o ${var1%.*}${var2} && ./${var1%.*}${var2}
}
cc() {
    var1=$1 && var2=.x && gcc -O2 -Wall $1 -o ${var1%.*}${var2} && ./${var1%.*}${var2}
}
#Rust
#--------------------------------------------------------------------------
rust() {
  var1=$1 && var2=.x && rustc $1 -o ${var1%.*}${var2} && ./${var1%.*}${var2}
}
cr() {
  cargo run $1
}
#git
dots() {
  config add $1; config commit -m $2; config push origin master
}
#--------------------------------------------------------------------------
gaiggi() {
  gaa && gcmsg $1 && gp
}
#Autojump
[[ -s /home/koho/.autojump/etc/profile.d/autojump.sh ]] && source /home/koho/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u# fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
