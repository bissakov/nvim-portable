$CWD = (Get-Location).Path

$ToolsDir = Join-Path $CWD "/tools/"
New-Item -Path $ToolsDir -ItemType Directory -Force | Out-Null

$NvimDir = Join-Path $CWD "/nvim-bin/"
if (-Not (Test-Path $NvimDir)) {
  $Zip = Join-Path $CWD "nvim.zip"
  Write-Host "Neovim not found, proceeding with download..."

  $release = Invoke-RestMethod "https://api.github.com/repos/neovim/neovim/releases/latest"

  $asset = $release.assets | Where-Object { $_.name -like "nvim-win64.zip" }

  if (-Not $asset) {
      Write-Error "Could not find portable Neovim asset."
      exit 1
  }

  Write-Host "Downloading $($asset.browser_download_url)"
  Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $Zip

  Expand-Archive -Path $Zip -DestinationPath $CWD -Force

  Remove-Item $Zip

  Rename-Item "nvim-win64" "nvim-bin"

  Write-Host "Done. Neovim extracted to $NvimDir"
}
else {
  Write-Host "Neovim already installed: $NvimDir"
}
Write-Host

$GitDir = Join-Path $ToolsDir "/git/"
$git = Get-Command askdhjaskj -ErrorAction SilentlyContinue
if ($git) {
    "Git is already installed"
} else {
  if (-Not (Test-Path $GitDir)) {
    $Zip = Join-Path $CWD "git.zip"
    Write-Host "Git not found, proceeding with portable MinGit download..."

    $release = Invoke-RestMethod "https://api.github.com/repos/git-for-windows/git/releases/latest"

    $asset = $release.assets | Where-Object { $_.name -like "MinGit-*-64-bit.zip" -and $_.name -notlike "*busybox*" }

    if (-Not $asset) {
        Write-Error "Could not find portable MinGit asset."
        exit 1
    }

    Write-Host "Downloading $($asset.browser_download_url)"
    Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $Zip

    Expand-Archive -Path $Zip -DestinationPath $GitDir -Force

    Remove-Item $Zip

    Write-Host "Done. Git extracted to $GitDir"
  }
  else {
    Write-Host "Git already installed: $GitDir"
  }
}
Write-Host

$FzfExe = Join-Path $ToolsDir "/fzf.exe"
if (-Not (Test-Path $FzfExe)) {
  $Zip = Join-Path $CWD "fzf.zip"
  Write-Host "fzf not found, proceeding with download..."

  $release = Invoke-RestMethod "https://api.github.com/repos/junegunn/fzf/releases/latest"

  $asset = $release.assets | Where-Object { $_.name -like "fzf-*-windows_amd64.zip" }

  if (-Not $asset) {
      Write-Error "Could not find portable fzf asset."
      exit 1
  }

  Write-Host "Downloading $($asset.browser_download_url)"
  Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $Zip

  Expand-Archive -Path $Zip -DestinationPath $ToolsDir -Force

  Remove-Item $Zip

  Write-Host "Done. fzf extracted to $ToolsDir"
}
else {
  Write-Host "fzf already installed: $FzfExe"
}
Write-Host

$RipgrepExe = Join-Path $ToolsDir "/rg.exe"
if (-Not (Test-Path $RipgrepExe)) {
  $Zip = Join-Path $CWD "rg.zip"
  Write-Host "ripgrep not found, proceeding with download..."

  $release = Invoke-RestMethod "https://api.github.com/repos/BurntSushi/ripgrep/releases/latest"

  $asset = $release.assets | Where-Object { $_.name -like "ripgrep-*-x86_64-pc-windows-msvc.zip" -and $_.name -notlike "*sha256*" }

  if (-Not $asset) {
      Write-Error "Could not find portable ripgrep asset."
      exit 1
  }

  Write-Host "Downloading $($asset.browser_download_url)"
  Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $Zip

  $TempDir = Join-Path $ToolsDir "/rg/"
  Expand-Archive -Path $Zip -DestinationPath $TempDir -Force

  $TempRgExe = .$FzfExe -e -f rg.exe
  Move-Item -Path $TempRgExe -Destination $ToolsDir -Force

  Remove-Item $Zip
  Remove-Item -Path $TempDir -Recurse -Force

  Write-Host "Done. ripgrep extracted to $ToolsDir"
}
else {
  Write-Host "ripgrep already installed: $RipgrepExe"
}
Write-Host

$FdExe = Join-Path $ToolsDir "/fd.exe"
if (-Not (Test-Path $FdExe)) {
  $Zip = Join-Path $CWD "fd.zip"
  Write-Host "fd not found, proceeding with download..."

  $release = Invoke-RestMethod "https://api.github.com/repos/sharkdp/fd/releases/latest"

  $asset = $release.assets | Where-Object { $_.name -like "fd-*-x86_64-pc-windows-msvc.zip" }

  if (-Not $asset) {
      Write-Error "Could not find portable fd asset."
      exit 1
  }

  Write-Host "Downloading $($asset.browser_download_url)"
  Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $Zip

  $TempDir = Join-Path $ToolsDir "/fd/"
  Expand-Archive -Path $Zip -DestinationPath $TempDir -Force

  $TempFdExe = .$FzfExe -e -f fd.exe
  Move-Item -Path $TempFdExe -Destination $ToolsDir -Force

  Remove-Item $Zip
  Remove-Item -Path $TempDir -Recurse -Force

  Write-Host "Done. fd extracted to $ToolsDir"
}
else {
  Write-Host "fd already installed: $FdExe"
}
Write-Host

$GoneovimExe = Join-Path $ToolsDir "/goneovim.exe"
if (-Not (Test-Path $GoneovimExe)) {
  $Zip = Join-Path $CWD "fd.zip"
  Write-Host "Goneovim not found, proceeding with download..."

  $release = Invoke-RestMethod "https://api.github.com/repos/akiyosi/goneovim/releases/latest"

  $asset = $release.assets | Where-Object { $_.name -like "goneovim-*-windows.zip" }

  if (-Not $asset) {
      Write-Error "Could not find portable goneovim asset."
      exit 1
  }

  Write-Host "Downloading $($asset.browser_download_url)"
  Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $Zip

  $TempDir = Join-Path $ToolsDir "/goneovim/"
  Expand-Archive -Path $Zip -DestinationPath $TempDir -Force

  $TempGoneovimExe = .$FzfExe -e -f goneovim.exe
  Move-Item -Path $TempGoneovimExe -Destination $ToolsDir -Force

  Remove-Item $Zip
  Remove-Item -Path $TempDir -Recurse -Force

  Write-Host "Done. Goneovim extracted to $ToolsDir"
}
else {
  Write-Host "Goneovim already installed: $GoneovimExe"
}
Write-Host

$FontDir = Join-Path $CWD "/fonts/"
New-Item -Path $FontDir -ItemType Directory -Force | Out-Null

if (-not (Get-ChildItem $FontDir -Force)) {
  $Zip = Join-Path $CWD "fira_code.zip"
  Write-Host "Fira Code fonts not found, proceeding with download..."

  $release = Invoke-RestMethod "https://api.github.com/repos/tonsky/FiraCode/releases/latest"

  $asset = $release.assets | Where-Object { $_.name -like "Fira_Code_*.zip" }

  if (-Not $asset) {
      Write-Error "Could not find portable Fira Code asset."
      exit 1
  }

  Write-Host "Downloading $($asset.browser_download_url)"
  Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $Zip

  $TempDir = Join-Path $CWD "/fira_code/"
  Expand-Archive -Path $Zip -DestinationPath $TempDir -Force

  Move-Item -Path (Join-Path $TempDir "ttf/*") -Destination $FontDir -Force

  Remove-Item $Zip
  Remove-Item -Path $TempDir -Recurse -Force

  Write-Host "Done. Fira Code extracted to $FontDir"
}
else {
  Write-Host "Fira Code already exists in $FontDir"
}
Write-Host

$NvimConfDir = Join-Path $CWD "nvim"
$GoneovimConfDir = Join-Path $CWD "goneovim"

if (-not $git) {
  $PortableGit = Join-Path $GitDir "cmd\git.exe"
  if (Test-Path $PortableGit) {
    Write-Host "Using portable git"
    $git = $PortableGit
  } else {
    Write-Error "Git not found."
    exit 1
  }
} else {
  Write-Host "Using global git"
  $git = $git.Source
}
Write-Host

if (-Not (Test-Path $NvimConfDir)) {
  Write-Host "Cloning Neovim configuration..."
  & $git clone https://github.com/bissakov/nvim.conf.git $NvimConfDir
}
else {
  Write-Host "Nvim configuration directory already exists. Updating..."
  pushd $NvimConfDir
  & $git pull
  popd
}
Write-Host

Write-Host "Moving Goneovim configuration to $GoneovimConfDir"
$NvimConfGoneovimConfDir = Join-Path $NvimConfDir "goneovim"
if (Test-Path $NvimConfGoneovimConfDir) {
  Move-Item -Path $NvimConfGoneovimConfDir -Destination $GoneovimConfDir -Force
}
Write-Host
