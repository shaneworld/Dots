if status is-interactive
  nitch
  nvm use latest -s
  set fish_greeting
  #set -x https_proxy http://localhost:7892
  #set -x http_proxy http://localhost:7892
  #set -x all_proxy socks5://localhost:7890
  set -gx EDITOR nvim
  set -gx GIT_EDITOR nvim
  #set -x PATH /home/shane/.asdf/installs/rust/stable/bin /home/shane/.cargo/bin/ $PATH
  alias vim "nvim"
  alias y "yazi"
  alias cat "bat"
  alias ls "eza -l"
  alias ll "eza -al"
  alias pc "sudo pacman -Sc"
  alias se "sudoedit"
end
