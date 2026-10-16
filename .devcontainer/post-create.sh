#!/usr/bin/env bash
set -euo pipefail

echo "==> Installing Ionic CLI"
npm install --global @ionic/cli

echo "==> Installing Entity Framework Core CLI"
dotnet tool install --global dotnet-ef || dotnet tool update --global dotnet-ef

echo "==> Configuring local .NET tools path"
if ! grep -q 'DOTNET_TOOLS_PATH' "$HOME/.bashrc" 2>/dev/null; then
  {
    echo ''
    echo '# .NET global tools'
    echo 'export PATH="$PATH:$HOME/.dotnet/tools"'
  } >> "$HOME/.bashrc"
fi
export PATH="$PATH:$HOME/.dotnet/tools"

echo "==> Tool versions"
dotnet --version
node --version
npm --version
ionic --version
java -version
echo "Dev container setup complete."
