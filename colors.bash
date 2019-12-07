#!/bin/bash

################################################################################
# Copyright Ⓒ 2019 ASoS Gaming
################################################################################
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
################################################################################
# curl https://raw.githubusercontent.com/asosgaming/nanorc/master/colors.bash | sudo bash  
################################################################################

apt-get update -y
apt-get install -y nano wget perl git
#user="$(getent passwd "1000" | cut -d: -f1)"

cat << EOF > /etc/skel/.bashrc
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case \$- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "\$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "\${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=\$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "\$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "\$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "\$color_prompt" = yes ]; then
    #PS1='\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\$ '
    PS1='\[\033[00;32m\]\u\[\033[00;90m\]@\[\033[00;32m\]\h\[\033[01;37m\] \[\033[01;37m\][\[\033[01;34m\]\w\[\033[01;37m\]]\[\033[00;32m\]\\$\[\033[00m\] '
    declare -x LS_COLORS='di=1;40;34:ln=1;40;36:so=4;40;35:pi=4;40;33:ex=1;40;32:bd=1;4;40;31:cd=1;4;40;33:su=37;41:sg=30;43:tw=30;42:ow=34;42:rs=0:mh=00:do=1;4;35:or=1;5;36;40:mi=01;05;31;40:ca=30;41:st=37;44:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=01;36:*.au=01;36:*.flac=01;36:*.mid=01;36:*.midi=01;36:*.mka=01;36:*.mp3=01;36:*.mpc=01;36:*.ogg=01;36:*.ra=01;36:*.wav=01;36:*.axa=01;36:*.oga=01;36:*.spx=01;36:*.xspf=01;36:*.conf=1;93:*.cnf=1;93:*.cfg=1;93:*.yaml=1;93:*.yml=1;93:*.toml=1;93'
else
    PS1='\${debian_chroot:+(\$debian_chroot)}\u@\h:\w\\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "\$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\${debian_chroot:+(\$debian_chroot)}\u@\h: \w\a\]\$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "\$(dircolors -b ~/.dircolors)" || eval "\$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF -h --color'
alias la='ls -A -h --color'
alias l='ls -CF -h --color'
alias maas='maas asos'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias df='df -h'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "\$([ \$? = 0 ] && echo terminal || echo error)" "\$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert\$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
EOF
echo "created /etc/skel/.bashrc"

while read -r user; do
    cp -vf /etc/skel/.bashrc /home/${user}/.bashrc
    chown -v ${user}:${user} /home/${user}/.bashrc
done < <(getent passwd | grep '/bin/bash' | grep '/home' | cut -d: -f1)

cat << EOF > /root/.bashrc
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "\$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "\$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "\$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=\$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "\$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "\$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "\$color_prompt" = yes ]; then
    #PS1='\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\$ '
    PS1='\[\033[00;31m\]\u\[\033[00;90m\]@\[\033[00;31m\]\h\[\033[01;37m\] \[\033[01;37m\][\[\033[01;34m\]\w\[\033[01;37m\]]\[\033[00;31m\]#\[\033[00m\] '
    declare -x LS_COLORS='di=1;40;34:ln=1;40;36:so=4;40;35:pi=4;40;33:ex=1;40;32:bd=1;4;40;31:cd=1;4;40;33:su=37;41:sg=30;43:tw=30;42:ow=34;42:rs=0:mh=00:do=1;4;35:or=1;5;36;40:mi=01;05;31;40:ca=30;41:st=37;44:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=01;36:*.au=01;36:*.flac=01;36:*.mid=01;36:*.midi=01;36:*.mka=01;36:*.mp3=01;36:*.mpc=01;36:*.ogg=01;36:*.ra=01;36:*.wav=01;36:*.axa=01;36:*.oga=01;36:*.spx=01;36:*.xspf=01;36:*.conf=1;93:*.cnf=1;93:*.cfg=1;93:*.yaml=1;93:*.yml=1;93:*.toml=1;93'
else
    PS1='\${debian_chroot:+(\$debian_chroot)}\u@\h:\w\\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "\$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\${debian_chroot:+(\$debian_chroot)}\u@\h: \w\a\]\$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "\$(dircolors -b ~/.dircolors)" || eval "\$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF -h --color'
alias la='ls -A -h --color'
alias l='ls -CF -h --color'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias df='df -h'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi
EOF
echo "created /root/.bashrc"

if [ -d /usr/share/nanorc ]; then
    git -C /usr/share/nanorc pull
else
    git clone git://github.com/asosgaming/nanorc.git /usr/share/nanorc
fi

timedatectl set-timezone America/New_York

rm -f /etc/skel/.nanorc
while read -r inc; do echo "include \"${inc}\"" >> /etc/skel/.nanorc; done < <(ls --color=none /usr/share/nanorc/*.nanorc)

ln -fvs /etc/skel/.nanorc /root/.nanorc
while read -r user; do
    ln -fvs /etc/skel/.nanorc /home/${user}/.nanorc
done < <(getent passwd | grep '/bin/bash' | grep '/home' | cut -d: -f1)

rm -vf /etc/update-motd.d/10-help-text
rm -vf /etc/update-motd.d/50-motd-news
rm -vf /etc/update-motd.d/80-esm
rm -vf /etc/update-motd.d/80-livepatch

cat << EOF > /etc/update-motd.d/00-header
#!/bin/bash

[ -r /etc/lsb-release ] && . /etc/lsb-release

if [ -z "\$DISTRIB_DESCRIPTION" ] && [ -x /usr/bin/lsb_release ]; then
        # Fall back to using the very slow lsb_release utility
        DISTRIB_DESCRIPTION=\$(lsb_release -s -d)
fi

host="\$(hostname -f)"
default="\$(uname -o) \$(uname -r) \$(uname -m)"
name=\${DISTRIB_DESCRIPTION-\$default}
printf "\e[39mWelcome to \e[97m%s \e[39m(\e[90m%s\e[39m)\e[39m\n" "\$host" "\$name"
EOF
echo "created /etc/update-motd.d/00-header"

cat << EOF > /etc/update-motd.d/50-landscape-sysinfo
#!/bin/bash

cores=\$(grep -c ^processor /proc/cpuinfo 2>/dev/null)
[ "\$cores" -eq "0" ] && cores=1
threshold="\${cores:-1}.0"
if [ \$(echo "`cut -f1 -d ' ' /proc/loadavg` < \$threshold" | bc) -eq 1 ]; then
    echo
    printf "  \e[39mSystem information as of \e[97m"
    printf "$(/bin/date '+%A, %B %d %I:%M%p') \e[39m(\e[90m$(/bin/date '+%Z %:z')\e[39m)\n"
    printf "  \e[93m—————————————————————————————————————————————————————————————————————————————\e[39m\n"
    while read -r line; do
        line="\${line//: /\\\\e[96m: \\\\e[97m}"
        line="\${line//System load/\\\\e[36mSystem load}"
        line="\${line/Usage of /\\\\e[36mUsage of \\\\e[39m}"
        line="\${line//Memory usage/\\\\e[36mMemory usage\\\\e[39m}"
        line="\${line//Swap usage/\\\\e[36mSwap usage\\\\e[39m}"
        line="\${line//Processes/\\\\e[36mProcesses\\\\e[39m}"
        line="\${line//Users logged in/\\\\e[36mUsers logged in\\\\e[39m}"
        line="\${line//IP address for /\\\\e[36mIP address for \\\\e[39m}"
#        line="\${line///\\\\e[36m\\\\e[39m}"
        echo -e "  \$line"
    done < <(/usr/bin/landscape-sysinfo)
    printf "  \e[93m—————————————————————————————————————————————————————————————————————————————\e[39m\n"
else
    echo
    printf " \e[91mSystem information disabled due to load higher than \$threshold\e[39m\n"
fi
EOF
echo "created /etc/update-motd.d/50-landscape-sysinfo"

cat << EOF > /etc/update-motd.d/90-updates-available
#!/bin/bash

stamp="/var/lib/update-notifier/updates-available"

while read -r line; do
    if [ "\$line" == "" ]; then continue; fi
    if [ "\${line:0:1}" == "0" ]; then color="\\e[39m"; else color="\\e[31m"; fi
    line="\${line//package/\${color}package}"
    line="\${line//updates/\${color}updates}"
    echo -e "  \e[97m\${line}\e[39m"
done < <(cat \$stamp)
EOF
echo "created /etc/update-motd.d/90-updates-available"
