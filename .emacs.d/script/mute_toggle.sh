#!/bin/bash

# 現在の設定を変数に放り込む
running=$(pactl list short sinks sink-inputs | sed -n 1p | cut -f 2)
# number=$(pactl list short sinks sink-inputs | cut -f 1)

pactl set-sink-mute ${running} toggle

# どっちのサウンドカードで音が鳴っているか判定
# if [ $running = 1 ]; then
#     target=0
# else
#     target=1
# fi

# 鳴ってないほうのサウンドカードに変更
# for i in ${number}; do
#     pactl move-sink-input $i $target
# done
