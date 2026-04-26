# nvim-config

Configuración personal de Neovim para desarrollo web (TypeScript · React · CSS/SCSS).
Teclado: Split 32 teclas · Layout: Colemak Mod-DH · Leader: `Space`

## Archivos

| Archivo | Descripción |
|---------|-------------|
| `vimrc` | Configuración principal (plugins, LSP, keymaps) — enlazar como `~/.vimrc` |
| `init.vim` | Entry point de Neovim — carga `~/.vimrc` |
| `MANUAL.md` | Referencia de todos los atajos de teclado |
| `PLAN.md` | Plan de implementación y decisiones de diseño |

## Instalación en una máquina nueva

### 1. Instalar dependencias

```bash
# Neovim 0.10+
brew install neovim

# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# LSP servers
npm install -g typescript typescript-language-server vscode-langservers-extracted

# Prettier (formateador)
npm install -g prettier

# telescope-fzf-native (requiere make)
brew install make
```

### 2. Crear directorios necesarios

```bash
mkdir -p ~/.vim/undodir
mkdir -p ~/.config/nvim
```

### 3. Copiar archivos

```bash
git clone https://github.com/pipe-code/nvim-config.git
cp nvim-config/vimrc ~/.vimrc
cp nvim-config/init.vim ~/.config/nvim/init.vim
```

### 4. Instalar plugins

```bash
nvim +PlugInstall +qall
```

## Plugins principales

- **Catppuccin Mocha** — colorscheme
- **Telescope + fzf-native** — fuzzy finder
- **nvim-lspconfig + nvim-cmp** — LSP y autocompletado
- **Treesitter** — syntax highlighting
- **conform.nvim + Prettier** — formateo (`<leader>p`)
- **Gitsigns + Fugitive + Diffview** — Git
- **Noice + nvim-notify** — UI moderna
- **Which-key** — popup de keymaps
- **Flash** — navegación rápida
- **oil.nvim** — file manager editable
- **nvim-ufo** — folding con LSP/treesitter
- **Barbecue + navic** — breadcrumbs en winbar
- **ccc.nvim** — color picker + preview inline (`<leader>cc`)
- **Copilot** — AI completion
