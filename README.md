# 🕹 Python ゲーム開発向けフォルダ構成例

```
python_game/
├─ .venv/                 # uv が作成する仮想環境（Git 管理しない）
├─ main.py                # ゲームのメインスクリプト
├─ pyproject.toml         # uv が管理する依存パッケージ情報
├─ uv.lock                # 依存バージョン固定用（チーム共有）
├─ README.md              # プロジェクト説明・セットアップ手順
├─ setup.sh               # 初回セットアップ用（再利用は不要）
├─ game/                  # ゲームのモジュールをまとめるディレクトリ
│   ├─ __init__.py
│   ├─ player.py
│   ├─ enemy.py
│   └─ level.py
├─ assets/                # 画像や音声などのゲームリソース
│   ├─ images/
│   └─ sounds/
├─ tests/                 # 単体テスト用
│   └─ test_player.py
└─ docs/                  # ドキュメント（設計メモ、仕様書など）
```

# 📌 運用手順
## 1️⃣ 仮想環境の有効化
```
cd ~/workspace/python_game
source .venv/bin/activate
```

- すべての作業は .venv 内で行う
- VSCode など IDE はこの仮想環境を Interpreter に設定

## 2️⃣ 依存パッケージの追加
```
uv add <package_name>
```

- 例：numpy や pygame、opencv-python など
- 自動で pyproject.toml と uv.lock に反映される

## 3️⃣ コード作成・モジュール化

- main.py はエントリーポイント
- ゲームの機能は game/ ディレクトリでモジュール化
```
# main.py
from game.player import Player
from game.enemy import Enemy

def main():
    player = Player()
    enemy = Enemy()
    print("ゲーム開始")
    
if __name__ == "__main__":
    main()
```

## 4️⃣ テスト
- tests/ に単体テストを置く

- 仮想環境内で pytest を使用
```
uv add pytest  # テスト用パッケージ
pytest tests/
```

## 5️⃣ 依存再現・チーム共有

- チームメンバーはプロジェクトをクローン後：
```
uv sync
```

- .venv が再作成され、uv.lock に基づく同一環境が構築される

## 6️⃣ Git 管理のおすすめ

- .gitignore に以下を追加：

```
.venv/
__pycache__/
*.pyc
*.pyo
```

- pyproject.toml, uv.lock, README.md, setup.sh は必ずコミット

## 7️⃣ ゲーム開発の流れ例
1. main.py にエントリポイント作成
2. 機能ごとに game/ 内にモジュールを追加
3. uv add <package> で必要ライブラリを追加
4. .venv 内で動作確認
5. テスト作成 → pytest 実行
6. 変更を Git にコミット


# 💡 ポイント
- .venv と uv を使うことで、依存管理と環境再現性が簡単
- モジュール分割でコードが整理され、テストや拡張がしやすくなる
- assets/ と docs/ でリソース・設計情報も分離して管理


## 1️⃣ プロジェクトに含まれる範囲

- コード本体
  - main.py や game/ のモジュールなど
  - 1つのゲームやアプリの機能単位
- 依存管理
  - pyproject.toml / uv.lock に記録されたライブラリ
  - .venv にインストールされている環境
- リソースやドキュメント
  - 画像・音声・データ → assets/
  - 設計メモや README → docs/ / README.md
- 初期セットアップ
  - setup.sh など、環境構築のためのスクリプト 

## 2️⃣ プロジェクトに含まれないもの
- 他のゲームや別のアプリ用のコード
- 別の .venv（別プロジェクトなら独立して作る）
- OS 全体の Python やグローバルなライブラリ

## 3️⃣ GitHub リポジトリ作成
1. GitHub にログイン
2. New repository → 名前を python_game に設定
3. Public / Private を選択
4. README.md は既にあるので「Initialize with README」はチェック不要

## 4️⃣ GitHub 連携
```
# GitHub リポジトリの URL に置き換える
git remote add origin git@github.com:USERNAME/python_game.git

# 追加・コミット
git add .
git commit -m "Initial commit"

# プッシュ（main ブランチを作る場合）
git branch -M main
git push -u origin main
```
