#!/usr/bin/env bash

# essential_config_linux.sh
# my settings

# aliases

cat << 'EOF' >> ~/.bashrc
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=20000
HISTTIMEFORMAT="%Y%m%d_%H%M%S%z % "
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
alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'
alias wanip2='curl http://ipecho.net/plain; echo'
alias wanip3='curl http://icanhazip.com; echo'
alias giveme8='head -c 1024 /dev/urandom | LC_ALL=C tr -cd "[:alpha:]" | fold -w 8'
EOF


# tmux
cat << 'EOF' >> ~/.tmux.conf
setw -g mouse on
# setw -g mode-mouse on
EOF

# vim UTF-8
cat << 'EOF' >> ~/.vimrc
set encoding=utf-8
set fileencoding=utf-8
EOF

# basic packages
mkdir -p "$HOME/_scripts"
touch "$HOME/_scripts/add-packages.sh"
chmod +x "$HOME/_scripts/add-packages.sh"

cat << 'EOF' >> "$HOME/_scripts/add-packages.sh"
#!/usr/bin/env bash
### Script must be run as root
# if [ $UID -ne 0 ]; then
if [ "$(id -u)" -ne 0 ]; then
   echo "You need to be root to run this script!"
   exit 1
   else
     echo "[*] You are root, continuing..."
fi
add_packages() {
  # add tcpdump htop vim curl wget python3
  echo "[*] Adding packages..."
  apt-get -qy update && apt-get -qy install python3 python-apt tcpdump htop vim curl wget lsof p7zip-full && echo "[*] apt-get install concluded successfully..." || echo "[ERROR] apt-get install did not execute correctly!"
}
EOF

# Show IP addresses on console via `/etc/issue`
{ echo 'IP addresses: \4 \6'; cat /etc/issue; } > /etc/issue.1; \
cp /etc/issue.1 /etc/issue
