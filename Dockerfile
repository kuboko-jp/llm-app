# ベースイメージ
FROM ubuntu:latest

# 必要なパッケージのインストール
RUN apt-get update && \
    apt-get install -y python3 python3-pip \
                       python3-venv \
                       build-essential \
                       && rm -rf /var/lib/apt/lists/*

# 仮想環境の作成
RUN python3 -m venv /opt/venv

# 仮想環境を有効にする
ENV PATH="/opt/venv/bin:$PATH"

# Pythonパッケージのインストール
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# ポートの設定
EXPOSE 8888

# 作業ディレクトリの設定
WORKDIR /work

# jupyterlab起動コマンド
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser"]