{ tmux, tmuxPlugins, writeText }:
{
  config = {
    name = ".tmux.conf";
    file = writeText "tmux.conf" (builtins.readFile ./tmux.conf);
  };
  binaries = [
    tmux
    tmuxPlugins.copycat
    tmuxPlugins.yank
    tmuxPlugins.fzf-tmux-url
  ];
}
