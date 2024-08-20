if status is-interactive
  status --is-interactive; and source (pyenv init - | source)
  nitch
  nvm use latest -s
  rbenv global 3.3.4
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
  set -gx PATH /home/shane/.local/share/gem/ruby/3.0.0/bin $PATH
  set -gx PATH /home/shane/.luarocks/bin/ $PATH
end
