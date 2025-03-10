<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 8803a6e8 (fix setting file)
#! python
# -*- coding: utf-8 -*-

from bs4 import BeautifulSoup
import re
import sys
import shutil
import os
from functools import reduce
from typing import List
from types import FunctionType, LambdaType


# htmlFile = "./test.html"
htmlFile = sys.argv[1]
pdfPath = "/home/toshiaki/Documents/PDF/ER"

# def c(*func: List[FunctionType]) -> LambdaType:
c = lambda *func: (lambda *args, **kwargs: []) if (l:=len(func)) < 1 else \
                  (lambda *args, **kwargs: func[0](*args, **kwargs)) if l == 1 else \
                  (lambda *args, **kwargs: func[0](func[1](*args, **kwargs))) if l == 2 else \
                  (lambda *args, **kwargs: c(*func[:-1])(func[-1](*args, **kwargs)))

# def c(*func: List[FunctionType]) -> LambdaType:
#     return {(l:=len(func)) < 1:lambda *args, **kwargs: [] ,
#               l == 1: lambda *args, **kwargs: func[0](*args, **kwargs),
#               l == 2: lambda *args, **kwargs: func[0](func[1](*args, **kwargs))
#               }.get(True, lambda *args, **kwargs: c(*func[:-1])(func[-1](*args, **kwargs)))

foldl1 = lambda func,ls: reduce(func, ls)

stringShaping = c(lambda x: f"{{{x}}}",
                  lambda x: re.sub(" +$", "", x),
                  lambda x: re.sub("^ +", "", x))
stringFeed = lambda feed, string: f"\t{feed} = {stringShaping(string)},\n"

# with open(htmlFile, "r", encoding="utf-8") as html:
#     soup = BeautifulSoup(html, "html.parser")

def makeBib(soup):
    title = soup.find_all("div", class_="document-title")[0].string
    authorInstitutionAddress = soup.find_all("div", class_="item-box box-03 mgb5")[0].string
    delSpace = c(lambda x: re.sub(" +$", "", x),
                 lambda x: re.sub("^ +", "", x))

    ls = c(list,
          lambda x: map(delSpace,x),
          lambda x: re.split(r"[\[\]/]", x))(authorInstitutionAddress)[:3]

    [author, institution, address] = ls
    abstract = re.sub("<[^>]+>", "", f"{soup.find_all('div', class_='item-box box-03 mgt5 mgb5')[0]}")
    year = soup.find_all("div", class_="item-box box-01 txtCenter mgt5")[0].string.split("/")[0]
    url = soup.find_all(class_="topagetop")[0].a["href"]
    reportID = soup.title.string.split()[0]
    fileName = reportID + ".pdf"

    makeKeywords = c(lambda ls: foldl1(lambda acc,x: f"{acc},{x}", ls),
                     lambda ls: map(lambda x: x.get_text().replace(" ","").replace("\n", ""), ls))

    keywords = makeKeywords(ks) if (ks:=soup.find_all(class_="item-box box-05")) else \
               ""

    feedList = [("title", title), ("author", re.sub(" ", ", ", author)), ("institution", institution), ("address", address),
                ("abstract", abstract), ("year", year), ("url",url),("file",fileName),("keywords",keywords)]

    feed = "" if not feedList else \
           c(lambda ls: foldl1(lambda acc,x: acc + x,ls),
             lambda ls: map(lambda x: stringFeed(x[0],x[1]),ls))(feedList)
    string = f"@TechReport{{1,\n{feed}}}"

    return [reportID, string]

readSoup = c(lambda x: BeautifulSoup(x, "html.parser"),
             lambda x: open(x, "r", encoding="utf-8"))

writeBib = lambda reportID, string: open(reportID + ".bib", "w", encoding="utf_8").write(string)

moveFile = lambda filePath, fileName: "nothing pdf file" if not os.path.exists(filePath) else \
                                      c(lambda x: "exist pdf file",
                                        lambda x: shutil.move(filePath, x),
                                        lambda x: os.path.join(pdfPath, x))(fileName)


def result(xs):
    [reportID, string] = xs
    fileName = reportID + ".pdf"
    filePath = os.path.join("./", fileName)

    print(filePath)
    _ = writeBib(reportID, string)
    return moveFile(filePath, fileName)

print(c(result,
        makeBib,
        readSoup)(htmlFile))
<<<<<<< HEAD
=======
#! python
# -*- coding: utf-8 -*-

from bs4 import BeautifulSoup
import re
import sys
import shutil
import os
from functools import reduce
from typing import List
from types import FunctionType, LambdaType


# htmlFile = "./test.html"
htmlFile = sys.argv[1]
pdfPath = "/home/toshiaki/Documents/PDF/ER"

# def c(*func: List[FunctionType]) -> LambdaType:
c = lambda *func: (lambda *args, **kwargs: []) if (l:=len(func)) < 1 else \
                  (lambda *args, **kwargs: func[0](*args, **kwargs)) if l == 1 else \
                  (lambda *args, **kwargs: func[0](func[1](*args, **kwargs))) if l == 2 else \
                  (lambda *args, **kwargs: c(*func[:-1])(func[-1](*args, **kwargs)))

# def c(*func: List[FunctionType]) -> LambdaType:
#     return {(l:=len(func)) < 1:lambda *args, **kwargs: [] ,
#               l == 1: lambda *args, **kwargs: func[0](*args, **kwargs),
#               l == 2: lambda *args, **kwargs: func[0](func[1](*args, **kwargs))
#               }.get(True, lambda *args, **kwargs: c(*func[:-1])(func[-1](*args, **kwargs)))

foldl1 = lambda func,ls: reduce(func, ls)

stringShaping = c(lambda x: f"{{{x}}}",
                  lambda x: re.sub(" +$", "", x),
                  lambda x: re.sub("^ +", "", x))
stringFeed = lambda feed, string: f"\t{feed} = {stringShaping(string)},\n"

# with open(htmlFile, "r", encoding="utf-8") as html:
#     soup = BeautifulSoup(html, "html.parser")

def makeBib(soup):
    title = soup.find_all("div", class_="document-title")[0].string
    authorInstitutionAddress = soup.find_all("div", class_="item-box box-03 mgb5")[0].string
    delSpace = c(lambda x: re.sub(" +$", "", x),
                 lambda x: re.sub("^ +", "", x))

    ls = c(list,
          lambda x: map(delSpace,x),
          lambda x: re.split(r"[\[\]/]", x))(authorInstitutionAddress)[:3]

    [author, institution, address] = ls
    abstract = re.sub("<[^>]+>", "", f"{soup.find_all('div', class_='item-box box-03 mgt5 mgb5')[0]}")
    year = soup.find_all("div", class_="item-box box-01 txtCenter mgt5")[0].string.split("/")[0]
    url = soup.find_all(class_="topagetop")[0].a["href"]
    reportID = soup.title.string.split()[0]
    fileName = reportID + ".pdf"

    makeKeywords = c(lambda ls: foldl1(lambda acc,x: f"{acc},{x}", ls),
                     lambda ls: map(lambda x: re.sub("\n? *<[^>]+>\n? *", "", x.get_text()), ls))

    keywords = makeKeywords(ks) if (ks:=soup.find_all(class_="item-box box-05")) else \
               ""

    feedList = [("title", title), ("author", re.sub(" ", ", ", author)), ("institution", institution), ("address", address),
                ("abstract", abstract), ("year", year), ("url",url),("file",fileName),("keywords",keywords)]

    feed = "" if not feedList else \
           c(lambda ls: foldl1(lambda acc,x: acc + x,ls),
             lambda ls: map(lambda x: stringFeed(x[0],x[1]),ls))(feedList)
    string = f"@TechReport{{1,\n{feed}}}"

    return [reportID, string]

<<<<<<< HEAD
    with open(reportID + ".bib", "w", encoding="utf_8") as of:
        of.write(string)
>>>>>>> 73c52a19 (add/fix ERを取り込むebib用スクリプトの追加と、設定の修正)
=======
readSoup = c(lambda x: BeautifulSoup(x, "html.parser"),
             lambda x: open(x, "r", encoding="utf-8"))

writeBib = lambda reportID, string: open(reportID + ".bib", "w", encoding="utf_8").write(string)

moveFile = lambda filePath, fileName: "nothing pdf file" if not os.path.exists(filePath) else \
                                      c(lambda x: "exist pdf file",
                                        lambda x: shutil.move(filePath, x),
                                        lambda x: os.path.join(pdfPath, x))(fileName)


def result(xs):
    [reportID, string] = xs
    fileName = reportID + ".pdf"
    filePath = os.path.join("./", fileName)

    print(filePath)
    _ = writeBib(reportID, string)
    return moveFile(filePath, fileName)

print(c(result,
        makeBib,
        readSoup)(htmlFile))
>>>>>>> 24570f11 (fix コードを整理)
=======
>>>>>>> 8803a6e8 (fix setting file)
