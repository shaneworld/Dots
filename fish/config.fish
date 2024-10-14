if status is-interactive
  nitch
  source /opt/asdf-vm/asdf.fish
  # alias cat "bat"
  #set -x https_proxy http://localhost:7890
  #set -x http_proxy http://localhost:7890
  #set -x all_proxy http://localhost:7890
  set -gx EDITOR nvim
  set -gx GIT_EDITOR nvim
  set -gx GTK_SCALE 2
  #set -gx SDL_VIDEODRIVER wayland
  #set -gx QT_QPA_PLATFORM wayland
  #set -gx PATH /home/shane/.local/share/gem/ruby/3.0.0/bin $PATH
  alias vim "nvim"
  alias y "yazi"
  alias cat "bat"
  alias ls "eza --icons -l"
  alias ll "eza --icons -al"
  alias pc "sudo pacman -Sc"
  alias se "sudoedit"
end
