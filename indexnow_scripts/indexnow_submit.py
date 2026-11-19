#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
厚道云 (Houdaoyun) IndexNow 自动化提交脚本 (Python 版)
"""

import json
import urllib.request
import urllib.error

HOST = "houdaoyun.sbs"
API_KEY = "e8c7b6a5d4f3e2b1c0a9f8e7d6c5b4a3"
KEY_LOCATION = f"https://{HOST}/{API_KEY}.txt"
ENDPOINT = "https://api.indexnow.org/indexnow"

URL_LIST = [
    f"https://{HOST}/",
    f"https://{HOST}/knowledge.html",
    f"https://{HOST}/article-1.html",
    f"https://{HOST}/article-2.html",
    f"https://{HOST}/article-3.html",
    f"https://{HOST}/article-4.html",
    f"https://{HOST}/article-5.html",
    f"https://{HOST}/article-6.html",
    f"https://{HOST}/article-7.html",
    f"https://{HOST}/article-8.html",
    f"https://{HOST}/article-9.html",
    f"https://{HOST}/about.html",
    f"https://{HOST}/terms.html",
    f"https://{HOST}/privacy.html",
    f"https://{HOST}/sitemap.html",
]

def submit():
    payload = {
        "host": HOST,
        "key": API_KEY,
        "keyLocation": KEY_LOCATION,
        "urlList": URL_LIST,
    }
    data = json.dumps(payload, ensure_ascii=False).encode("utf-8")
    req = urllib.request.Request(
        ENDPOINT,
        data=data,
        headers={"Content-Type": "application/json; charset=utf-8"},
        method="POST"
    )

    print("=" * 60)
    print(" 厚道云 IndexNow URL 提交工具 (Python 版)")
    print(f" 目标站点: {HOST}")
    print(f" 提交数量: {len(URL_LIST)} 个 URL")
    print("=" * 60)

    try:
        with urllib.request.urlopen(req) as resp:
            code = resp.getcode()
            print(f"[SUCCESS] 提交成功！HTTP 状态码: {code}")
    except urllib.error.HTTPError as e:
        if e.code in (200, 202):
            print(f"[SUCCESS] 提交成功！HTTP 状态码: {e.code}")
        else:
            print(f"[NOTE] 服务器返回状态码: {e.code} ({e.reason})")
            print("提示：若当前域名解析或网站尚未正式上线绑定，IndexNow 将在域名上线并可校验 keyLocation 后正式完成索引。")
    except Exception as e:
        print(f"[ERROR] 请求发生异常: {e}")

if __name__ == "__main__":
    submit()
