if status is-interactive
  status --is-interactive; and source (pyenv init - | source)
  nitch
  nvm use latest -s
  set -g fish_greeting
  alias vim "nvim"
  alias y "yazi"
  alias ls "exa --icons -l"
  alias ll "exa --icons -al"
  alias pc "sudo pacman -Sc"
  alias se "sudoedit"
  # alias cat "bat"
  set -x https_proxy http://localhost:7897
  set -x http_proxy http://localhost:7897
  set -x all_proxy http://localhost:7897
  set -gx EDITOR nvim
  set -gx GIT_EDITOR nvim
end

function sdk
    bash -c "source '$HOME/.sdkman/bin/sdkman-init.sh'; sdk $argv[1..]"
end
