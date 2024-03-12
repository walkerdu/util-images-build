git config --global user.name 'walkerdu'
git config --global user.email 'walkerdu@tencent.com'
git config --global core.editor vim
git config --global credential.helper store
git config --global merge.tool vimdiff
git config --global core.autocrlf false
git config --global pull.rebase true 
git config --global submodule.recurse true

alias git-log='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %an %s %Cgreen(%ad)%Creset'\'' --abbrev-commit --date='\''iso'\'''
