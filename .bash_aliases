alias 7zinfected='7z a sample-`myts`-pwd-infected.zip -tzip -mem=AES256 -pinfected'
alias BASH_ALIAS_FILES='cat ~/.bash_aliases'
alias bashRemoveSpacesFromFilenames='for name in *\ *; do mv -v "$name" "${name// /}"; done'
alias cO='curl -O'
alias deletebyinode='echo "use: ls -lai to find \$INODE; then run: TMPFILENAME=\$(cat /dev/urandom | base64 | tr -dc a-zA-Z0-9 | fold -w 32 | head -n 1); find . -inum \$INODE -exec mv {} $TMPFILENAME \; -exec rm $TMPFILENAME \;"'
alias digreverse='dig +noall +answer -x'
alias download='cO'
alias edit_alias='vim ~/.bashrc'
alias grepc='grep --color=auto'
alias grepipaddr='grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"'

alias idna-encode-utf8-string="python -c 'import sys;print sys.argv[1].decode(\"utf-8\").encode(\"idna\")'"
alias idna-decode-idna-domain="python -c 'import sys;print sys.argv[1].decode(\"idna\").encode(\"utf-8\")'"

alias kp='ps auxwww'
alias l='ls -lAhF -G'
alias la='ls -la -G'
alias li='ls -la -G -i'
alias ll='ls -lahF -G'
alias lsoftcp='sudo lsof -i TCP'
alias lsoftcp22='sudo lsof -i TCP:22 -P'
alias lsoftcp443='sudo lsof -i TCP:443 -P'
alias lsoftcp80='sudo lsof -i TCP:80 -P'
alias lt='ls -la -G -Tt'
alias mktemp32='echo `cat /dev/urandom | base64 | tr -dc a-zA-Z0-9 | fold -w 32 | head -n 1`'
alias mp='ps ajf'
alias mydate='date +%Y%m%d'
alias myts='date +%Y%m%d-%H%M%S%z'

case "$OSTYPE" in
  darwin*)  echo "OSX"
  alias osxcpucores='sysctl -n hw.ncpu'
  alias osxpreview='echo usage: "open -a Preview \$file"; open -a Preview'
  alias resetlaunchpad='echo "This alias resets MacOSX LaunchPad Dock Widget"; defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock'
  alias ts_to_date_macosx='date -f %s -j -u'
  ;;

alias resize1280='mkdir 1280;for f in *JPG; do convert -resize 1280 -quality 85% $f ./1280/$f; done; ll 1280'
alias sha1sum='shasum -a 1'
alias sha256sum='shasum -a 256'
alias showmethematrix='COL=$(( $(tput cols) / 2 )); clear; tput setaf 2; while :; do tput cup $((RANDOM%COL)) $((RANDOM%COL)); printf "%$((RANDOM%COL))s" $((RANDOM%2)); done'
alias sortipv4='sort -t . -k 1,1n -k 2,2n -k 3,3n -k 4,4n'
alias squidtime='awk '\''{printf "%s", strftime("%F %T UTC", $1, 1);   $1=""; print $0}'\'''
alias ts_to_date_linux='echo \`date "+%Y%m%d-%H%M%S%z" -ud @1415161718\`, where 1415161718 is your timestamp to convert'
alias urlencode-quote-string='python -c '\''import sys,urllib;print urllib.quote(sys.argv[1])'\'''
alias urlencode-unquote-string='python -c '\''import sys,urllib;print urllib.unquote(sys.argv[1])'\'''

alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'
alias wanip2='curl http://ipecho.net/plain; echo'
alias wanip3='curl http://icanhazip.com; echo'

giveme-pass() {
	length=$1
	echo "yielding a complex passphrase with length: $length"
	LC_CTYPE=C tr -dc A-Za-z0-9_\!\@\#\$\%\^\&\*\(\)-+= < /dev/urandom | fold -w $length | head -n 1
}

7zpackdir() {
	
	DIR="$1"	# the dir to be compressed
	OUTFILE="$DIR-`myts`-pwd-infected.zip"
	7z a "$OUTFILE" -tzip -mem=AES256 -pinfected $DIR
}


giveme() {
	length=$1
	echo "giving out a simple passphrase with length: $length"
	LC_CTYPE=C tr -dc A-Za-z0-9 < /dev/urandom | fold -w $length | head -n 1
}


gs_resize_a4 () {
	echo "This function will resize all pages of a given PDF to A4"
	file="$1"
	outfile=$(basename -s .pdf "$file")_a4.pdf
	echo "Input File: $file, Output File: $outfile"
	gs -o "$outfile" -sDEVICE=pdfwrite -sPAPERSIZE=a4 -dFIXEDMEDIA -dPDFFitPage -dCompatibilityLevel=1.4 "$file"
}


gs_reduce_pdf_quality_ebook () {

	#-dPDFSETTINGS=/screen   (screen-view-only quality, 72 dpi images)
	#-dPDFSETTINGS=/ebook    (low quality, 150 dpi images)
	#-dPDFSETTINGS=/printer  (high quality, 300 dpi images)
	#-dPDFSETTINGS=/prepress (high quality, color preserving, 300 dpi imgs)
	#-dPDFSETTINGS=/default  (almost identical to /screen)

	quality="/ebook"
	inputfile=$1
	outputfile="${inputfile%%.*}_$(echo $quality | tr -d ' /' ).pdf"

	if [[ ! -z "$1" ]]; then
		gs -q -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -sOutputFile="$outputfile" "$inputfile"
	else
		echo "Use gs to reduce PDF quality to $quality"
		echo "Usage: $0 Inputfile.pdf"
		echo "Output will be written to Inputfile_$(echo $quality | tr -d ' /' ).pdf"
	fi
}
