# Peccato Neovim Config

Terminal-first конфигурация Neovim для Rust/Linux-разработки: минимальный IDE-like интерфейс, файловый менеджер, быстрый поиск, Rust LSP, диагностика, Git-маркеры и интеграция с OpenAI Codex CLI.

Конфиг собран как практичный daily-driver: без зоопарка плагинов, без религиозного Vim-аскетизма.

## Возможности

Основной стек:

- модульная Lua-конфигурация Neovim;
- `lazy.nvim` как менеджер плагинов;
- `oil.nvim` как файловый менеджер;
- `telescope.nvim` для быстрого поиска;
- `nvim-treesitter` для подсветки и синтаксиса;
- `rust-analyzer` для Rust LSP;
- `catppuccin` как тема;
- `lualine.nvim` как статусбар;
- `gitsigns.nvim` для Git-маркеров;
- `trouble.nvim` для диагностики;
- `which-key.nvim` для подсказок клавиш;
- интеграция с OpenAI Codex CLI через терминальный split.

## Философия

Конфигурация рассчитана на:

- Linux-native разработку;
- Rust backend / infra / devtools workflow;
- работу из терминала;
- низкий визуальный шум;
- предсказуемые горячие клавиши;
- быструю навигацию по проекту;
- минимальные, но полезные IDE-функции.

Цель — не превратить Neovim в тяжёлый Electron-клон, а получить быстрый системный редактор.

## Требования

### Системные пакеты

Fedora:

```bash
sudo dnf install -y \
  neovim \
  git \
  ripgrep \
  fd-find \
  gcc \
  clang \
  nodejs \
  npm \
  cargo \
  rust-analyzer \
  unzip \
  curl \
  fontconfig
