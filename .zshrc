export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="zhann"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

# noti-sound: set notification sound by name, file path, or stop
# Drop .oga/.wav/.mp3 files in ~/.local/share/noti-sounds/ to use by name
noti-sound() {
  local name="${1:-}"
  local sounds_dir="${NOTI_SOUNDS_DIR:-$HOME/.local/share/noti-sounds}"
  local link="$HOME/.local/share/noti-sounds/current.oga"

  if [ -z "$name" ]; then
    echo "Usage: noti-sound <name|path|off>"
    echo ""
    echo "Available sounds:"
    if [ -d "$sounds_dir" ]; then
      for f in "$sounds_dir"/*.{oga,wav,mp3}(N); do
        [ -f "$f" ] && echo "  $(basename "${f%.*}")"
      done
    fi
    echo ""
    echo "  off         Stop notification sounds"
    echo "  /any/path   Use any audio file"
    return
  fi

  if [ "$name" = "off" ]; then
    systemctl --user stop notification-sound.service 2>/dev/null
    echo "Notification sounds stopped"
    return
  fi

  local src=""
  if [ -f "$name" ]; then
    src="$name"
  else
    for ext in oga wav mp3; do
      [ -f "$sounds_dir/$name.$ext" ] && src="$sounds_dir/$name.$ext" && break
    done
  fi

  if [ -n "$src" ]; then
    ln -sf "$src" "$link"
    systemctl --user restart notification-sound.service 2>/dev/null
    echo "Notification sound set: $(basename "${src%.*}")"
  else
    echo "Sound '$name' not found"
    echo "Drop .oga/.wav/.mp3 files in $sounds_dir"
    return 1
  fi
}

_noti-sound() {
  local sounds_dir="${NOTI_SOUNDS_DIR:-$HOME/.local/share/noti-sounds}"
  local -a names
  names=("off")
  if [ -d "$sounds_dir" ]; then
    for f in "$sounds_dir"/*.{oga,wav,mp3}(N); do
      [ -f "$f" ] && names+=("${f%.*}")
    done
  fi
  _describe 'noti-sound' names
}
compdef _noti-sound noti-sound
export PATH="$HOME/.local/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/mysyntax/.lmstudio/bin"
# End of LM Studio CLI section

