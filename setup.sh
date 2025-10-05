#!/bin/bash
# setup.sh - Intel Mac 用 pyenv + uv + PyTorch 環境構築

# 実行方法
# chmod +x setup.sh
# ./setup.sh

set -e

echo "=== 1. Xcode Command Line Tools ライセンス承認 ==="
sudo xcodebuild -license accept

echo "=== 2. Homebrew 更新と依存ライブラリインストール ==="
brew update
sudo chown -R $(whoami) /usr/local/lib /usr/local/bin /usr/local/share /usr/local/etc /usr/local/Cellar /usr/local/var
brew install openssl readline zlib xz pyenv

echo "=== 3. pyenv 設定 (zshの場合) ==="
if ! grep -q "PYENV_ROOT" ~/.zshrc; then
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(pyenv init --path)"' >> ~/.zshrc
    echo 'eval "$(pyenv init -)"' >> ~/.zshrc
fi
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

echo "=== 4. Python ビルド用環境変数設定 ==="
export LDFLAGS="-L/usr/local/opt/openssl/lib -L/usr/local/opt/readline/lib -L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include -I/usr/local/opt/readline/include -I/usr/local/opt/zlib/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig:/usr/local/opt/readline/lib/pkgconfig:/usr/local/opt/zlib/lib/pkgconfig"

echo "=== 5. Python 3.10.12 インストール ==="
pyenv install -s 3.10.12
pyenv global 3.10.12
python --version

echo "=== 6. uv インストール ==="
curl -LsSf https://astral.sh/uv/install.sh | sh
if ! grep -q ".local/bin" ~/.zshrc; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
fi
export PATH="$HOME/.local/bin:$PATH"

echo "=== 7. プロジェクト作成 ==="
read -p "プロジェクト名を入力してください: " PROJECT_NAME
mkdir -p ~/workspace/$PROJECT_NAME
cd ~/workspace/$PROJECT_NAME

echo "=== 8. uv プロジェクト初期化 ==="
uv init

echo "=== 9. 依存パッケージ追加 ==="
uv add numpy opencv-python torch torchvision torchaudio

echo "=== 10. 仮想環境有効化 ==="
echo "source .venv/bin/activate を実行して仮想環境に入れます"

echo "=== セットアップ完了 ==="
echo "cd ~/workspace/$PROJECT_NAME して、source .venv/bin/activate を実行してください"
