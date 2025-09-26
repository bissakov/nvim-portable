## Portable Neovim installation script
The script downloads portable Neovim, MinGit, fzf, ripgrep, fd, Goneovim, Fira Code and [my Neovim configuration](https://github.com/bissakov/nvim.conf).

## Installation

### Powershell
```powershell
git clone https://github.com/bissakov/nvim-portable.git

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
.\install.ps1
.\start-shell.bat
goneovim
```

### CMD
```powershell
git clone https://github.com/bissakov/nvim-portable.git

powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1
.\start-shell.bat
goneovim
```

Manually install Fira Code fonts.