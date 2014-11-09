#!/usr/bin/env python
#-*- coding:utf-8 -*-
from main import *

# 报告系统

# 故障上报系统
class Fault:
    @Check_Login
    def GET(self):
        sData = getLogin()
        SID = sData['SID']
        ShowName = sData['ShowName']
        return render.report_fault(ShowName=ShowName,uid=SID)

