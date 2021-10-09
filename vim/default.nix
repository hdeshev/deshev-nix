{ neovim, vimPlugins, vimUtils, fzf }:
let
  personal = vimUtils.buildVimPlugin {
    pname = "deshev-vimconfig";
    version = "1.0.0";
    src = ./deshev;
    meta = {
      homepage = https://github.com/hdeshev;
    };
  };
  fzf-plugin = vimUtils.buildVimPlugin {
    pname = "fzf-plugin";
    version = "1.0.0";
    src = "${fzf}/share/vim-plugins/*";
  };
  vim-commaobject = vimUtils.buildVimPlugin {
    pname = "vim-commaobject";
    version = "1.0.0";
    src = ./vim-commaobject;
    meta = {
      homepage = https://github.com/austintaylor/vim-commaobject;
    };
  };
  vim-js-indent = vimUtils.buildVimPlugin {
    pname = "vim-js-indent";
    version = "1.0.0";
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
        vim-go
        completion-nvim
        coc-nvim
        plenary-nvim
        popup-nvim
        telescope-nvim
        lspsaga-nvim
        nvim-lspconfig
      ];
    };
  }
