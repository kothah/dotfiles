# .bash_profile 
# For CentOS 
# updated by
# Hardik Kothari

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin
export PATH
#   -------------------------------
#   ENVIRONMENT CONFIGURATION
#   -------------------------------

#   Change Prompt
#   ------------------------------------------------------------
#   export PS1="\w @ \h(\u)-> "
   export PS1="________________________________________________________________________________\n| \w @ \h (\u) \n| => "
   export PS2="| => "
#   Set Paths
#   ------------------------------------------------------------
   export PATH="$PATH:/usr/local/bin"

#   Set Default Editor (change 'Vim' to the editor of your choice)
#   ------------------------------------------------------------
#   export EDITOR=/usr/bin/vim

#   Set default blocksize for ls, df, du
#   ------------------------------------------------------------
   export BLOCKSIZE=1k

#  -----------------------------
#   2.  MAKE TERMINAL BETTER
#   -----------------------------
alias ls='ls --color -Gp'			    # Preferred ‘ls’ implementation
alias l.='ls -d -Gp .*'                     # show hidden files
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
# alias less='less -FSRXc'                  # Preferred 'less' implementation
cd() { builtin cd "$@"; ls; }               # Always list directory contents upon 'cd'
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
# alias edit='subl'                           # edit:         Opens any file in sublime editor
alias ~='cd ~'                              # ~:            Go Home
alias c='clear'                             # c:            Clear terminal display
alias which='type -all'                     # which:        Find executables
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias show_options='shopt'                  # Show_options: display bash options settings
alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview
alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on Desktop

alias h='history' 
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

#   lr:  Full Recursive Directory Listing
#   ------------------------------------------
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

#   mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
#           displays paginated result with colored search terms and two lines surrounding each hit. 
#   Example: mans mplayer codec
#   --------------------------------------------------------------------
    mans () {
       man $1 | grep -iC2 --color=always $2 | less
   }

#   showa: to remind yourself of an alias (given some part of it)
#   ------------------------------------------------------------
   showa () { /usr/bin/grep --color=always -i -a1 $@ ~/Library/init/bash/aliases.bash | grep -v '^\s*$' | less -FSRXc ; }


#   -------------------------------
#   FILE AND FOLDER MANAGEMENT
#   -------------------------------

zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder
alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir
alias make1mb='mkfile 1m ./1MB.dat'         # make1mb:      Creates a file of 1mb size (all zeros)
alias make5mb='mkfile 5m ./5MB.dat'         # make5mb:      Creates a file of 5mb size (all zeros)
alias make10mb='mkfile 10m ./10MB.dat'      # make10mb:     Creates a file of 10mb size (all zeros)

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
    extract () {
       if [ -f $1 ] ; then
         case $1 in
           *.tar.bz2)   tar xjf $1     ;;
           *.tar.gz)    tar xzf $1     ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar e $1     ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xf $1      ;;
           *.tbz2)      tar xjf $1     ;;
           *.tgz)       tar xzf $1     ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)     echo "'$1' cannot be extracted via extract()" ;;
            esac
        else
            echo "'$1' is not a valid file"
        fi
   }


#   ---------------------------
#   SEARCHING
#   ---------------------------

alias qfind="find . -name "                 # qfind:    Quickly search for file
ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string

#   ---------------------------
#   PROCESS MANAGEMENT
#   ---------------------------

#   findPid: find out the pid of a specified process
#   -----------------------------------------------------
#       Note that the command name can be specified via a regex
#       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#       Without the 'sudo' it will only find processes of the current user
#   -----------------------------------------------------
   findPid () { lsof -t -c "$@" ; }

#   memHogsTop, memHogsPs:  Find memory hogs
#   -----------------------------------------------------
   alias memHogsTop='top -l 1 -o rsize | head -20'
   alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

#   cpuHogs:  Find CPU hogs
#   -----------------------------------------------------
   alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

#   topForever:  Continual 'top' listing (every 10 seconds)
#   -----------------------------------------------------
   alias topForever='top -l 9999999 -s 10 -o cpu'

#   ttop:  Recommended 'top' invocation to minimize resources
#   ------------------------------------------------------------
   alias ttop="top -F -s 10 -o rsize"

#   my_ps: List processes owned by my user:
#   ------------------------------------------------------------
   my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }


#   ---------------------------
#   NETWORKING
#   ---------------------------

alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs

#   ii:  display useful host related information
#   -------------------------------------------------------------------
   ii() {
       echo -e "\nYou are logged on ${RED}$HOST"
       echo -e "\nAdditionnal information:$NC " ; uname -a
       echo -e "\n${RED}Users logged on:$NC " ; w -h
       echo -e "\n${RED}Current date :$NC " ; date
       echo -e "\n${RED}Machine stats :$NC " ; uptime
       echo -e "\n${RED}Current network location :$NC " ; scselect
       echo -e "\n${RED}Public facing IP Address :$NC " ;myip
       echo
   }
