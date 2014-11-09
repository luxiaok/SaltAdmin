#!/usr/bin/env python
#-*- coding:utf-8 -*-
from main import *

# 监控中心

# Redis
class M_Redis:
    def GET(self):
        if getLogin():
            sData = getLogin()
            SID = sData['SID']
            ShowName = sData['ShowName']
            #print sData            
            #print "ShowName: " + ShowName
            return render.monitor_redis(ShowName=ShowName,uid=SID)
        else:
            web.setcookie('HTTP_REFERER', web.ctx.fullpath, 86400)
            return web.seeother("/login")
# MySQL
class M_MySQL:
    def GET(self):
        if getLogin():
            sData = getLogin()
            SID = sData['SID']
            ShowName = sData['ShowName']
            #print sData            
            #print "ShowName: " + ShowName
            return render.monitor_mysql(ShowName=ShowName,uid=SID)
        else:
            web.setcookie('HTTP_REFERER', web.ctx.fullpath, 86400)
            return web.seeother("/login")

# 网络流量
class M_Traffic:
    def GET(self):
        if getLogin():
            sData = getLogin()
            SID = sData['SID']
            ShowName = sData['ShowName']
            #print sData            
            #print "ShowName: " + ShowName
            return render.monitor_bandwidth(ShowName=ShowName,uid=SID)
        else:
            web.setcookie('HTTP_REFERER', web.ctx.fullpath, 86400)
            return web.seeother("/login")
