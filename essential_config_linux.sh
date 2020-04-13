# essential_config_linux.sh
# my settings

# aliases

cat << 'EOF' >> ~/.bashrc

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=20000

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

EOF

cat << 'EOF' >> ~/.bash_aliases

alias 7zinfected='7z a sample-`myts`-pwd-infected.zip -tzip -mem=AES256 -pinfected'
alias bashRemoveSpacesFromFilenames='for name in *\ *; do mv -v "$name" "${name// /}"; done'
alias cO='curl -O'
alias download='cO'

alias idna-encode-utf8-string="python -c 'import sys;print sys.argv[1].decode(\"utf-8\").encode(\"idna\")'"
alias idna-decode-idna-domain="python -c 'import sys;print sys.argv[1].decode(\"idna\").encode(\"utf-8\")'"

alias kp='ps auxwww'
alias l='ls -lahs --color'
alias ll='ls -lahs --color'
alias li='ls -la -G -i'

alias lsoftcp='sudo lsof -i TCP'
alias lsoftcp22='sudo lsof -i TCP:22 -P'
alias lsoftcp443='sudo lsof -i TCP:443 -P'
alias lsoftcp80='sudo lsof -i TCP:80 -P'
alias lt='ls -la -G -Tt'

alias mktemp32='echo `cat /dev/urandom | base64 | tr -dc a-zA-Z0-9 | fold -w 32 | head -n 1`'
alias mp='ps ajf'
alias mydate='date +%Y%m%d'
alias myts='date +%Y%m%d-%H%M%S%z'

alias sortipv4='sort -t . -k 1,1n -k 2,2n -k 3,3n -k 4,4n'
alias squidtime='awk '\''{printf "%s", strftime("%F %T UTC", $1, 1);   $1=""; print $0}'\'''
alias ts_to_date_linux='echo \`date "+%Y%m%d-%H%M%S%z" -ud @1415161718\`, where 1415161718 is your timestamp to convert'
EOF


# tmux
cat << 'EOF' >> ~/.tmux.conf
# setw -g mouse on
setw -g mode-mouse on
EOF

# vim UTF-8
cat << 'EOF' >> cat ~/.vimrc
set encoding=utf-8
set fileencoding=utf-8
EOF

# disable ipv6
sudo echo 'net.ipv6.conf.all.disable_ipv6 = 1' > /etc/sysctl.d/01-disable-ipv6.conf