# Plan de Implementación — Neovim Setup

> Stack: TypeScript · React/TSX · CSS/SCSS · HTML · JSON
> Teclado: Split 32 teclas · Colemak Mod-DH · Leader = Space

---

## Plugins instalados

| Categoría      | Plugin                                      | Estado |
|----------------|---------------------------------------------|--------|
| Tema           | catppuccin/nvim (mocha)                     | ✅     |
| Tema           | dracula/vim                                 | ✅ fallback |
| IA             | github/copilot.vim                          | ✅     |
| Explorador     | preservim/nerdtree                          | ✅     |
| Explorador     | stevearc/oil.nvim                           | ✅     |
| Buscador       | nvim-telescope/telescope.nvim               | ✅     |
| Buscador       | telescope-fzf-native.nvim                   | ✅     |
| LSP            | neovim/nvim-lspconfig                       | ✅     |
| Autocompletado | hrsh7th/nvim-cmp + cmp-nvim-lsp/buffer/path | ✅     |
| Snippets       | L3MON4D3/LuaSnip + cmp_luasnip             | ✅     |
| Formateo       | stevearc/conform.nvim                       | ✅     |
| Comentarios    | numToStr/Comment.nvim                       | ✅     |
| Comentarios    | JoosepAlviste/nvim-ts-context-commentstring | ✅     |
| Edición        | tpope/vim-surround                          | ✅     |
| Edición        | windwp/nvim-autopairs                       | ✅     |
| Navegación     | folke/flash.nvim                            | ✅     |
| Git            | lewis6991/gitsigns.nvim                     | ✅     |
| Git            | tpope/vim-fugitive                          | ✅     |
| Git            | sindrets/diffview.nvim                      | ✅     |
| Sesiones       | tpope/vim-obsession                         | ✅     |
| UI             | nvim-lualine/lualine.nvim                   | ✅     |
| UI             | nvim-tree/nvim-web-devicons                 | ✅     |
| UI             | lukas-reineke/indent-blankline.nvim         | ✅     |
| UI             | akinsho/bufferline.nvim                     | ✅     |
| UI             | uga-rosa/ccc.nvim                           | ✅     |
| UI             | stevearc/dressing.nvim                      | ✅     |
| UI             | rcarriga/nvim-notify                        | ✅     |
| UI             | folke/noice.nvim                            | ✅     |
| UI             | folke/which-key.nvim                        | ✅     |
| UI             | SmiteshP/nvim-navic                         | ✅     |
| UI             | utilyre/barbecue.nvim                       | ✅     |
| Folding        | kevinhwang91/nvim-ufo + promise-async       | ✅     |
| Animaciones    | echasnovski/mini.animate                    | ✅     |
| Sintaxis       | nvim-treesitter/nvim-treesitter             | ✅     |

---

## LSP Servers activos

- **ts_ls** — TypeScript / JavaScript
- **cssls** — CSS / SCSS
- **html** — HTML
- **jsonls** — JSON (con validación)

---

## Roadmap

### Completado
- [x] Setup base + tema Dracula → migrado a **Catppuccin Mocha**
- [x] LSP + autocompletado (nvim-cmp + LuaSnip)
- [x] Git workflow: gitsigns (hunks) + fugitive (comandos) + diffview (diffs visuales)
- [x] Gestión de sesiones (vim-obsession)
- [x] Keybindings optimizados para Colemak Mod-DH (split 32 teclas)
- [x] Statusline con indicador de sesión activa (lualine)
- [x] Breadcrumbs de contexto LSP (barbecue + navic)
- [x] Folding mejorado con treesitter/LSP (nvim-ufo)
- [x] Navegación rápida (flash.nvim)
- [x] Popup de keymaps (which-key)
- [x] File manager editable (oil.nvim)
- [x] Color picker + preview inline (ccc.nvim) — reemplaza nvim-colorizer
- [x] Formateo con Prettier (conform.nvim)
- [x] UI moderna: cmdline flotante, notificaciones animadas (noice + nvim-notify)
- [x] Popups de input/select elegantes (dressing.nvim)
- [x] Búsqueda fzf nativa acelerada (telescope-fzf-native)
- [x] Clipboard integrado con macOS (`set clipboard=unnamed`)
- [x] Fix error `ft_to_lang` de Telescope en Neovim 0.10+

### Pendiente — Media prioridad
- [ ] **nvim-lint** — linting asíncrono (eslint)
- [ ] **nvim-dap** — debugging (breakpoints, variables, call stack)
- [ ] **nvim-dap-ui** — interfaz visual para DAP

### Pendiente — Baja prioridad
- [ ] Migración de vim-plug a **lazy.nvim** (carga lazy, más rápido)

---

## Notas de arquitectura

- `init.vim` delega todo a `~/.vimrc` para mantener compatibilidad vim/nvim
- La configuración Lua se embebe con bloques `lua << EOF` en el vimrc
- Los keymaps de LSP se activan solo en buffers con servidor LSP adjunto (autocmd `LspAttach`)
- Treesitter se instala async en `VimEnter` (no bloquea el arranque)
- `mini.animate`: scroll y cursor desactivados (conflicto con Magic Mouse), solo resize activo
- Telescope previewers usan highlighting nativo (no treesitter) para evitar error `ft_to_lang` en Neovim 0.10+
- `gitsigns` reemplaza `vim-gitgutter`: mismos atajos de hunks + blame inline (`<leader>gB`)
- `ccc.nvim` reemplaza `nvim-colorizer`: agrega color picker interactivo (`<leader>cc`) además del preview inline
- `noice` tiene `input = { enabled = false }` para que NERDTree (m) use el input nativo de Neovim
