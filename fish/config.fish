if status is-interactive
  nitch
  source /opt/asdf-vm/asdf.fish
  #set -x https_proxy http://localhost:7892
  #set -x http_proxy http://localhost:7892
  #set -x all_proxy socks5://localhost:7890
  set -gx EDITOR nvim
  set -gx GIT_EDITOR nvim
  set -gx GTK_SCALE 2
  #set -gx SDL_VIDEODRIVER wayland
  #set -gx QT_QPA_PLATFORM wayland
  set -gx PATH /home/shane/.asdf/installs/lua/5.1.5/luarocks/bin $PATH
  #set -x LUA_PATH "$HOME/.luarocks/share/lua/5.4/?.lua;$HOME/.luarocks/share/lua/5.4/?/init.lua"
  #set -x LUA_CPATH "$HOME/.luarocks/lib/lua/5.4/?.so"
  #set -x LUA_PATH "/usr/share/lua/5.4/?.lua;/usr/share/lua/5.4/?/init.lua"
  #set -x LUA_CPATH "/usr/lib/lua/5.4/?.so"


  alias vim "nvim"
  alias y "yazi"
  #alias cat "bat"
  alias ls "eza --icons -l"
  alias ll "eza --icons -al"
  alias pc "sudo pacman -Sc"
  alias se "sudoedit"
end
