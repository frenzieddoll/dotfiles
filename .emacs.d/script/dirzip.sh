#!/bin/zsh
emulate -R sh

list=$(find . -mindepth 1 -maxdepth 1 -type d)

if [ $list = ""]; then
    echo "ディレクトリはありません"
    return
else
    echo "${list}"
    echo "ディレクトリを圧縮しますか?[y/n]"
    read ans
fi

# 圧縮するかの判定
if [ $ans = "y" ]; then
    # echo $list | xargs -I{} zip -r {}.zip {}
    echo "test"
    echo "圧縮完了しました"
else
    echo "圧縮しませんでした"
fi
