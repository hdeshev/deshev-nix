{ neovim, vimPlugins, vimUtils, fzf }:
let
  personal = vimUtils.buildVimPlugin {
    name = "personal";
    src = ./deshev;
    meta = {
      homepage = https://github.com/hdeshev;
    };
  };
  fzf-plugin = vimUtils.buildVimPlugin {
    name = "fzf-plugin";
    src = "${fzf}/share/vim-plugins/*";
  };
  vim-commaobject = vimUtils.buildVimPlugin {
    name = "vim-commaobject";
    src = ./vim-commaobject;
    meta = {
      homepage = https://github.com/austintaylor/vim-commaobject;
    };
  };
  vim-js-indent = vimUtils.buildVimPlugin {
    name = "vim-js-indent";
    src = ./vim-js-indent;
    meta = {
      homepage = https://github.com/jason0x43/vim-js-indent;
    };
  };
in
  neovim.override {
    configure = {
      customRC = builtins.readFile ./vimrc;
      plug.plugins = with vimPlugins; [
        personal
        vim-vinegar
        bufexplorer
        editorconfig-vim
        fzf-plugin
        fzf-vim
        nerdcommenter
        ale
        tagbar
        typescript-vim
        vim-commaobject
        vim-js-indent
        vim-nix
        vim-repeat
        vim-addon-mw-utils
        tlib
        vim-snipmate
        vim-surround
      ];
    };
  }
