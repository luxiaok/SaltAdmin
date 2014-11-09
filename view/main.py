#!/usr/bin/env python
#-*- coding:utf-8 -*-
from config.setting import *

def make_html(s):
    return web.websafe(s).replace('\r\n', '<br />')
web.template.Template.globals['make_html'] = make_html

# Get Seession ID and ShowName
def getLogin():
    if web.config._session.get('isLogin') is False:
        return False
    else:
        return {'SID':web.config._session.SID,
                'Username':web.config._session.Username,
                'Token':web.config._session.Token,
                'ShowName':web.config._session.ShowName,
                'LastDate':web.config._session.LastDate,
                'LastIP':web.config._session.LastIP,
                'LastLocation':web.config._session.LastLocation,
                'Lstat':web.config._session.Lstat}

# 定义登录检查装饰函数
def Check_Login(func):
    def inner(*args):
        if web.config._session.get('isLogin') is True:
            return func(*args)
        else:
            web.setcookie('HTTP_REFERER', web.ctx.fullpath, 86400)
            return web.seeother("/login")
    return inner

# 定义公共函数: 格式化时间戳
def format_timestamp(s):
    s = int(float(s))
    D = 0 
    H = 0 
    M = 0 
    S = s 
    if S > 59: 
        M = S / 60
        S = S % 60
        if M > 59: 
            H = M / 60
            M = M % 60
            if H > 23: 
                D = H / 24
                H = H % 24
    return "%d天%d小时%d分%d秒" % ( D, H, M, S )

# Define 404
def notfound():
    #return web.notfound(render.info("404","404 - Not Found"))
    #return web.notfound("404 - Not Found")
    #return web.notfound("<center>Developing ~~~ <br />Coming Soon ~~! <br /><I>Design By Luxiaok</I></center>")
    if getLogin():
        SID = getLogin()['SID']
        ShowName = getLogin()['ShowName']
        return web.notfound(render.test(ShowName=ShowName,uid=SID))
    else:
        web.setcookie('HTTP_REFERER', web.ctx.fullpath, 86400)
        #return web.seeother("/login")
        return web.notfound(render.login())
web.webapi.notfound = notfound

# Define 500
def internalerror():
    return web.internalerror("500 - Internal Error")
web.webapi.internalerror = internalerror

#if __name__ == "__main__":
#    app = web.application(urls, globals())
#    app.run()

