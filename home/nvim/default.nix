{ pkgs, lib, ... }:
{
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    luaLoader.enable = true;

    # Override nixvim's internal pkgs lookup for unfree deps so they pick up
    # the host pkgs (which has allowUnfree configured).
    dependencies.claude-code.package = pkgs.claude-code;

    colorschemes.catppuccin.enable = true;

    opts = {
      virtualedit = "block";
      cursorline = true;

      number = true;
      relativenumber = true;
      signcolumn = "yes";

      hlsearch = true;
      incsearch = true;

      splitbelow = true;
      splitright = true;

      ignorecase = true;
      smartcase = true;

      expandtab = true;
      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 2;

      encoding = "utf-8";
      fileencoding = "utf-8";

      updatetime = 250;
      timeoutlen = 400;
      scrolloff = 6;
      sidescrolloff = 8;

      undofile = true;
      confirm = true;
      mouse = "a";

      foldcolumn = "1";
      foldlevel = 99;
      foldlevelstart = 99;
      foldenable = true;
      fillchars = {
        eob = " ";
        fold = " ";
        foldopen = "▾";
        foldclose = "▸";
        foldsep = "│";
      };
    };

    diagnostic.settings = {
      virtual_text = true;
      severity_sort = true;
      underline = true;
      float.border = "rounded";
    };

    plugins = {
      telescope.enable = true;
      harpoon.enable = true;
      sleuth.enable = true;
      rustaceanvim.enable = true;
      web-devicons.enable = true;
      claude-code.enable = true;

      jdtls = {
        enable = true;
        settings.root_dir.__raw = ''
          vim.fs.dirname(vim.fs.find(
            { "gradlew", "mvnw", "build.gradle", "build.gradle.kts", "pom.xml", ".git" },
            { upward = true }
          )[1])
        '';
      };

      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
          incremental_selection.enable = true;
        };
      };

      treesitter-textobjects = {
        enable = true;
        settings.select = {
          enable = true;
          lookahead = true;
          keymaps = {
            "af" = "@function.outer";
            "if" = "@function.inner";
            "ac" = "@class.outer";
            "ic" = "@class.inner";
            "ab" = "@block.outer";
            "ib" = "@block.inner";
            "aa" = "@parameter.outer";
            "ia" = "@parameter.inner";
          };
        };
      };

      blink-cmp = {
        enable = true;
        setupLspCapabilities = true;
        settings = {
          keymap.preset = "enter";
          completion = {
            documentation.auto_show = true;
            list.selection.preselect = true;
            ghost_text.enabled = true;
          };
          signature.enabled = true;
          sources.default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];
        };
      };

      lsp = {
        enable = true;
        autoLoad = true;
        inlayHints = true;
        keymaps = {
          silent = true;
          diagnostic = {
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
            "<leader>e" = "open_float";
          };
          lspBuf = {
            gd = "definition";
            gD = "declaration";
            gi = "implementation";
            gr = "references";
            gt = "type_definition";
            K = "hover";
            "<leader>rn" = "rename";
            "<leader>ca" = "code_action";
            "<leader>f" = "format";
          };
        };
        servers = {
          bashls.enable = true;
          clangd.enable = true;
          cmake.enable = true;
          nil_ls.enable = true;
          lua_ls.enable = true;
          ts_ls.enable = true;
          kotlin_language_server.enable = true;
          html.enable = true;
          cssls.enable = true;
          jsonls.enable = true;
          marksman.enable = true;
          eslint.enable = true;
          basedpyright.enable = true;
          ruff.enable = true;
          ruby_lsp.enable = true;
          gopls.enable = true;
          verible.enable = true;
          emmet_language_server = {
            enable = true;
            filetypes = [
              "html"
              "css"
              "scss"
              "javascriptreact"
              "typescriptreact"
            ];
          };
          # Rust is handled by rustaceanvim, Java by nvim-jdtls.
          rust_analyzer.enable = false;
        };
      };

      conform-nvim = {
        enable = true;
        autoInstall.enable = true;
        settings = {
          formatters_by_ft = {
            nix = [ "nixfmt" ];
            sh = [ "shfmt" ];
            bash = [ "shfmt" ];
            lua = [ "stylua" ];
            c = [ "clang_format" ];
            cpp = [ "clang_format" ];
            yaml = [ "yamlfmt" ];
            javascript = [ "prettierd" ];
            javascriptreact = [ "prettierd" ];
            typescript = [ "prettierd" ];
            typescriptreact = [ "prettierd" ];
            html = [ "prettierd" ];
            css = [ "prettierd" ];
            scss = [ "prettierd" ];
            json = [ "prettierd" ];
            jsonc = [ "prettierd" ];
            markdown = [ "prettierd" ];
            java = [ "google-java-format" ];
            kotlin = [ "ktlint" ];
            python = [ "ruff_format" ];
            ruby = [ "rubocop" ];
            go = [
              "goimports"
              "gofumpt"
            ];
            verilog = [ "verible" ];
            systemverilog = [ "verible" ];
            cmake = [ "cmake_format" ];
            "_" = [
              "trim_whitespace"
              "trim_newlines"
            ];
          };
          formatters = {
            clang_format.condition.__raw = ''
              function(_, ctx)
                return vim.fs.root(ctx.filename, ".clang-format") ~= nil
              end
            '';
            prettierd.condition.__raw = ''
              function(_, ctx)
                return vim.fs.root(ctx.filename, {
                  ".prettierrc",
                  ".prettierrc.json",
                  ".prettierrc.yaml",
                  ".prettierrc.yml",
                  ".prettierrc.json5",
                  ".prettierrc.js",
                  ".prettierrc.cjs",
                  ".prettierrc.mjs",
                  ".prettierrc.toml",
                  "prettier.config.js",
                  "prettier.config.cjs",
                  "prettier.config.mjs",
                }) ~= nil
              end
            '';
            stylua.condition.__raw = ''
              function(_, ctx)
                return vim.fs.root(ctx.filename, { "stylua.toml", ".stylua.toml" }) ~= nil
              end
            '';
          };
        };
      };

      lualine.enable = true;
      which-key.enable = true;

      gitsigns = {
        enable = true;
        settings = {
          signs = {
            add.text = "▎";
            change.text = "▎";
            delete.text = "";
            topdelete.text = "";
            changedelete.text = "▎";
            untracked.text = "▎";
          };
          current_line_blame = true;
          current_line_blame_opts.delay = 500;
        };
      };

      todo-comments.enable = true;
      trouble.enable = true;
      fidget.enable = true;
      notify.enable = true;
      colorizer.enable = true;
      rainbow-delimiters.enable = true;
      nvim-ufo.enable = true;
      oil.enable = true;

      flash = {
        enable = true;
        settings.modes.search.enabled = false;
      };

      mini = {
        enable = true;
        modules = {
          ai = { };
          surround = { };
          pairs = { };
          indentscope = {
            symbol = "│";
            options.try_as_border = true;
          };
          move = { };
          bracketed = { };
          trailspace = { };
        };
      };
    };

    autoCmd = [
      {
        event = "FileType";
        pattern = [
          "go"
          "make"
        ];
        command = "setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=0";
      }
      {
        event = "FileType";
        pattern = [
          "python"
          "java"
          "kotlin"
          "c"
          "cpp"
        ];
        command = "setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4";
      }
      {
        event = "TextYankPost";
        pattern = "*";
        callback.__raw = ''
          function()
            vim.hl.on_yank({ timeout = 200 })
          end
        '';
      }
      {
        event = "BufWritePre";
        pattern = "*";
        callback.__raw = ''
          function(args)
            local conform = require("conform")
            local ok_gs, gs = pcall(require, "gitsigns")
            local hunks = ok_gs and gs.get_hunks(args.buf) or nil

            -- Untracked buffer: format the whole thing.
            if hunks == nil then
              conform.format({
                bufnr = args.buf,
                timeout_ms = 2000,
                lsp_format = "fallback",
              })
              return
            end

            -- Tracked: format only changed hunks, bottom-up so earlier
            -- line numbers don't shift as later ranges get rewritten.
            for i = #hunks, 1, -1 do
              local hunk = hunks[i]
              if hunk.type ~= "delete" and hunk.added.count > 0 then
                local first = hunk.added.start
                local last = first + hunk.added.count - 1
                local last_line =
                  vim.api.nvim_buf_get_lines(args.buf, last - 1, last, true)[1] or ""
                conform.format({
                  bufnr = args.buf,
                  range = {
                    start = { first, 0 },
                    ["end"] = { last, #last_line },
                  },
                  timeout_ms = 2000,
                  lsp_format = "fallback",
                })
              end
            end
          end
        '';
      }
    ];
  };
}
