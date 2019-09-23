#!/bin/zsh
emulate -R sh

# rootユーザーのみ実行
if [ "$USER" != "root" ]; then
    echo 'This Script can used root only' # 英語はでたらめです。
    exit
fi

# list=$(pip list)

# # アップデートがあるかの判定
# if [ $list = ""]; then
#     # echo "アップデートはありません"
#     return
# else
#     echo "${list}"
#     echo "アップデートしますか?[y/n]"
#     read ans
# fi

# # アップデートを行なうかの判定
# if [ $ans = "y" ]; then
#     updatalist=$(echo "${list}" | awk '{print $1}' | tail -n +3)
#     for row in $updatalist; do
#         echo ${row}
#     done
# else
#     echo "アップデートはしません"
#     return
# fi

# ver. 2
# アップデートがあるパッケージの取得
list=$(pip list --o)

# アップデートがあるかの判定
if [ $list = ""]; then
    echo "アップデートはありません"
    return
else
    echo "${list}"
    echo "アップデートしますか?[y/n]"
    read ans
fi

# アップデートを行なうかの判定
if [ $ans = "y" ]; then
    updatalist=$(echo "${list}" | awk '{print $1}' | tail -n +3)
    for row in $updatalist; do
        pip install ${row} -U
    done
else
    echo "アップデートはしません"
    return
fi

# ver.1
# updatelist=$(pip list --o | awk '{print $1}' |tail -n +3)

# for i in $updatelist
# do
#     pip install ${i} -U
# done
