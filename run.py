#!/usr/bin/env python
#-*- coding:utf-8 -*-
import web
import os
from view.main import *

app = web.application(urls, globals())

curdir = os.path.dirname(__file__)

web.config.session_parameters['cookie_name'] = 'xk_session'
web.config.session_parameters['ignore_expiry'] = False
web.config.session_parameters['timeout'] = 86400
expired_message = '''
<html lang="zh-CN">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script Language="JavaScript">alert("会话已过期，请重新登录！"); window.location.href="/login";</script>
	</head>
<html>
'''
web.config.session_parameters['expired_message'] = expired_message
if web.config.get('_session') is None:    
    # 会话成功，写入9个值到session里
    # session初始化
    session = web.session.Session(
        app,
        web.session.DiskStore('session'),
        initializer = {
        'isLogin':False,
        'SID':None,
        'Username':None,
        'Token':None,
        'ShowName':None,
        'LastIP':'127.0.0.1',
        'LastLocation':'China',
        'LastDate':'Long Long Ago',
        'Lstat':'ok'})
    web.config._session = session
else:
    session = web.config._session

#print web.config.session_parameters

if __name__ == "__main__":
    # 使用webpy内置的web服务器
    app.run()
    # Nginx + uWSGI运行模式, 两种运行方式只能选择一个
    #application = app.wsgifunc()

