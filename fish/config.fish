if status is-interactive
  nitch
  set fish_greeting
  source /opt/asdf-vm/asdf.fish
  #set -x https_proxy http://localhost:7892
  #set -x http_proxy http://localhost:7892
  #set -x all_proxy socks5://localhost:7890
  set -gx EDITOR nvim
  set -gx GIT_EDITOR nvim
  alias vim "nvim"
  alias y "yazi"
  alias cat "bat"
  alias ls "eza --icons -l"
  alias ll "eza --icons -al"
  alias pc "sudo pacman -Sc"
  alias se "sudoedit"
end
