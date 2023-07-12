# ベースイメージ
FROM centos:7

# ロケールを日本語に変更とyesコマンドの無効化
RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 && \
	ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
	echo -e "export LANG=ja_JP.UTF-8 LANGUAGE=ja_JP:ja TZ=Asia/Tokyo\nalias yes='printf '\'''\'''" >> /etc/bashrc && \
	sed -i 's/LANG="en_US.UTF-8"/LANG="ja_JP.UTF-8"/g' /etc/locale.conf && \
	# yum.confで日本語環境、ドキュメントをインストールするように変更
	sed -i -e '/override_install_langs.*/d' -e '/tsflags.*/d' /etc/yum.conf

# 各種コマンドインストール
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
	yum clean all && \
	yum install -y less sudo psmisc which wget httpd mlocate bzip2\
	vim-enhanced vim-filesystem vim-common \
	man-db man-pages-ja man-pages man-pages-overrides && \
	# 日本語化、マニュアル作成のため全パッケージの再インストール
	yum -y reinstall $(yum list installed | cut -f1 -d " " | sed 's/\..*$//g' | grep -v '^[L|I].*ed$' | sed -z 's/\n/ /g')

# manドキュメント追加
RUN mandb

# コンテナ内ルートユーザーにパスワード設定
RUN echo "root:centos" | chpasswd

# ログインユーザーを作成
ARG UID=1000
RUN useradd -m -u ${UID} usera && \
# 作成したログインユーザーにパスワードを設定
echo "usera:usera" | chpasswd

# 作成したログインユーザーに切り替える
USER ${UID}
WORKDIR /home/usera/
mkdir ダウンロード デスクトップ ビデオ 画像 テンプレート ドキュメント 音楽 公開

# コンテナ実行時のデフォルトコマンド
CMD ["/bin/bash"]
