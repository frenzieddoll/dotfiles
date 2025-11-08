#! /usr/bin/python

import base64
import pyperclip
from io import BytesIO
from PIL import Image
# import sys
# from pathlib import Path
import argparse

parser = argparse.ArgumentParser(description="クリップボードのbase64からpngへデコードし、画像を保存するスクリプト")
parser.add_argument('fileName', help="保存するときのファイル名")
# parser.add_argument('--size')

args = parser.parse_args()
# print(args.fileName)
# args_count = len(sys.argv) - 1

# クリップボードからデータを取得する
data = pyperclip.paste()
# print(data)
# data = sys.argv[2]

# base64デコードして画像データを復元する
img_data = base64.b64decode(data)

# Pillowを使って画像を読み込む
image = Image.open(BytesIO(img_data))

# print(sys.argv[1])
# print(sys.argv[2])

# fileName = "image.png" if args_count < 1 else f"{sys.argv[1]}.png"


# 画像を保存する
image.save(f"{args.fileName}.png", "PNG")
# print(fileName)
