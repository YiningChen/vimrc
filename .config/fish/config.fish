# Setting fish as default shell
# 1. Add “/usr/local/bin/fish” to “/etc/shells”
# 2. Run: “chsh -s /usr/local/bin/fish”

# Base16 Shell
if status --is-interactive
  source $HOME/.config/base16-shell/profile_helper.fish
end
