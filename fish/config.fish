if status is-interactive
  nitch
  source /opt/asdf-vm/asdf.fish
  # alias cat "bat"
  set -x https_proxy http://localhost:7897
  set -x http_proxy http://localhost:7897
  set -x all_proxy http://localhost:7897
  set -gx EDITOR nvim
  set -gx GIT_EDITOR nvim
  set -gx PATH /home/shane/.local/share/gem/ruby/3.0.0/bin $PATH
  alias vim "nvim"
  alias y "yazi"
  alias ls "eza --icons -l"
  alias ll "eza --icons -al"
  alias pc "sudo pacman -Sc"
  alias se "sudoedit"
end
