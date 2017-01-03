#!/usr/bin/env python
#-*- coding:utf-8 -*-
from main import *
import time
import random
import urllib2
import json
#import os

def genToken(L):
    CharLib = map(chr,range(97,123)+range(65,91)+range(48,58))
    Str = []
    for i in range(L):
        Str += random.sample(CharLib,1)
    return ''.join(Str)

# Key is md5 for string "xiaok"
key = 'db884468559f4c432bf1c1775f3dc9da'

# 加密UID
def encryptUID(id):
    return key + str(id)

# 解密SID
def decryptUID(uStr):
    return int(uStr.split('a')[1])

# 获取cookies
def getCookie(name):
    ck = web.cookies()
    if ck.get(name):
        return ck.get(name)
    else:
        return None

# 创建会话
def genSession(SID,Username,ShowName,LastIP,LastLocation,LastDate,Token,Lstat,kpl):
    LoginDate = time.strftime("%Y-%m-%d %H:%M:%S",time.localtime(time.time()))
    Expiry = 86400
    session = web.config._session
    session.isLogin = True
    session.SID = SID
    session.Username = Username
    session.ShowName = ShowName
    session.LastLocation = LastLocation
    # 登录是否正常返回
    if Lstat == 'ok':
        session.Lstat = '正常'
    elif Lstat == 'other':
        session.Lstat = '您的上次登录在别的电脑或者别的浏览器'
    else:
        session.Lstat = '未知'
    # 获取客户端信息
    #print 'HTTP_ENV: '
    #print web.ctx.environ #来源地址
    #print 'HTTP_REFERER: '
    #print web.ctx.env.get('HTTP_REFERER', 'http://google.com')
    #LoginHost = web.ctx.ip #这两种方法都能获取到客户端IP
    LoginHost = web.ctx.environ['REMOTE_ADDR']
    Agent = web.ctx.environ['HTTP_USER_AGENT']
    # 测试解析
    #LoginHost = '119.122.181.82'
    # 本次登录地点判断
    Location = 'Localhost'
    ip = LoginHost.split('.')
    if ip[0]+ip[1] in ['17216','192168','1270'] or ip[0] == '10':
        Location = '本地局域网'
    else:
        # 这里要从公网去解析
        url = "http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=json&ip=" + LoginHost
        response = urllib2.urlopen(url)
        rt = json.load(response)
        if rt['ret'] == 1 :
            Location = rt['province'] + rt['city'] + ' [' + rt['isp'] + ']'
        else:
            Location = 'unkown'
    # 登录日志写入数据库
    if not Token:
        # Token用来判断是否输入的用户名登录验证的还是从token验证过来的
        Token = genToken(32)
        if kpl == 'no':
            Expiry = 0 # 不记住登录，设置数据库里存储的token的过期时间与登录时间相等
        #db.query('''update users set loginhost="%s",logindate="%s" where id="%s"''' % (LoginHost,LoginDate,SID))
        db.query('''insert into login_logs (uid,ip,location,agent,token,expiry) values ("%s","%s","%s","%s","%s",NOW() + INTERVAL %d SECOND)''' % (SID,LoginHost,Location,Agent,Token,Expiry))
        db.query('''update users set loginfo=(select id from login_logs where uid="%s" and ip="%s" and token="%s" and  status="yes" order by id desc limit 1) where id="%s"''' % (SID,LoginHost,Token,SID))
    # 写入token到session，存储于服务器端
    session.Token = Token
    # 写入uid和token到cookies，存储于客户端
    #web.setcookie('Username', Username, Expiry)
    #用uid伪装成Username存储在cookies中
    web.setcookie('Username', encryptUID(SID), Expiry)
    web.setcookie('Token', Token, Expiry)
    # 写入上次登录日期和IP到session
    if LastDate:
        # 格式化日期，加上年月日在前台显示，如果为None，表示用户是第一次登录
        session.LastDate = time.strftime('%Y年%m月%d日 %H:%M:%S',time.strptime(str(LastDate),'%Y-%m-%d %H:%M:%S'))
    else:
        session.LastDate = '第一次登录'
    session.LastIP = LastIP
    # 写入当前登录日期和IP到数据库设计说明：
    # 1.如果用户登录成功，就会从数据库获取上次登录的时间和IP，并写入session，然后立马把本次登录的IP和时间更新到数据库
    # 2.还有一种方法就是用户登录时把本次登录的时间和IP写入session而先不动数据库里的记录，直到用户执行正常退出操作时再把session里存储的本次登录的信息写入数据库
    # 3.第1个方法和第2个方法记录的数据是相反的，为什么不用第2种呢，因为万一用户不是正常退出呢，那数据库就不会更新本次登录的信息，所以...
    # By Luxiaok 2014年4月7日 22:49:00
    # 登录成功,这里执行DB操作应该要有异常处理的
    # return True

class Login:
    def GET(self,*args):
        # URL做了多项正则匹配，要进行参数冗余处理，还不知道为什么url正则后会给GET传个参数进来
        # 多余的参数就是匹配的url后缀
        #print "Self =",self
        #print "Args =",args
        uid = getCookie('Username')
        token = getCookie('Token')
        sid = getCookie('xk_session')
        HTTP_REFERER = getCookie('HTTP_REFERER')
        #print 'Login referer from cookie: ',HTTP_REFERER
        if uid and token:
            #print 'uid =',uid
            #print 'token =',token
            #print 'sid =',sid
            uid = decryptUID(uid)
            try:
                g = db.query('''
                    select U.id,U.username,U.nickname,U.loginfo,L.id as LID,L.ip,L.date from login_logs as L
                    left join users as U on L.uid=U.id
                    where U.id="%s" and L.token="%s" and L.status="yes" and L.expiry>now() and U.status="yes"''' % (uid,token))
            except Exception,e:
                print "MySQL Error: ",Exception,":",e
                return "Database Error"
            if g:
                d = g[0]
                Username = d.username
                Lstat = 'ok' #是否异常登录反馈
                if not d.nickname:
                    ShowName = d.username
                else:
                    ShowName = d.nickname
                if d.loginfo != d.LID:
                    g2 = db.query('''select L.ip,L.date from users as U left join login_logs as L on U.loginfo=L.id where U.id="%s"''' % uid)
                    d = g2[0]
                    # 这里还可以返回一个异地浏览器登录的提示
                    Lstat = "other" #上次登录在别的浏览器或者异地、异机
                LastIP = d.ip
                LastDate = d.date
                genSession(uid,Username,ShowName,LastIP,LastDate,token,Lstat,kpl='yes')
                if HTTP_REFERER:
                    web.setcookie('HTTP_REFERER', '88888888', -1000)
                    return web.seeother(HTTP_REFERER)
                else:
                    return web.seeother("/dashboard")

            else:
                # 如果数据库里存储的token状态为no，即用户已经正常退出，会话无效了，那么清除本地cookies
                web.setcookie('Username', '88888888', -1)
                web.setcookie('Token', '88888888', -1)
        if getLogin():
            #SID = getLogin()['SID']
            ShowName = getLogin()['ShowName']
            #print "ShowName: " + ShowName       
            return render.dashboard(ShowName=ShowName)
        else:
            #return web.seeother("/login")
            return render.login()
    
    def POST(self,*args):
        getPost = web.input()
        #kpl = getPost.kpl # 是否记住登录
        try:
            getSQL = db.query('''select u.id,u.username,u.password,u.nickname,u.status,L.ip,L.location,L.date from users as u left join login_logs as L on u.loginfo=L.id where username="%s" and password=md5("%s")''' % (getPost.username,getPost.password))
        except:
            # 服务器(数据库)错误
            web.header('Content-Type', 'application/json')
            return json.dumps({'code':-1,'msg':'数据库错误'})
        if getSQL:
            # 获取登录数据
            getData = getSQL[0]
            SID = getData['id']
            Username = getData['username']
            Status = getData['status']
            ShowName = getData['nickname']
            LastDate = getData['date']
            LastIP = getData['ip']
            LastLocation = getData['location']
            if not ShowName:
                ShowName = Username
            if Status == 'yes':
                # 符合登录要求，登录数据写入session，创建会话
                genSession(SID,Username,ShowName,LastIP,LastLocation,LastDate,False,Lstat='ok',kpl=getPost.kpl)
                #HTTP_REFERER = getCookie('HTTP_REFERER')
                #if HTTP_REFERER:
                #    web.setcookie('HTTP_REFERER', '88888888', -1000)
                #    return web.seeother(HTTP_REFERER)
                #else:
                #    web.setcookie('HTTP_REFERER', '88888888', -1000)
                #    return web.seeother("/dashboard")
                web.header('Content-Type', 'application/json')
                return json.dumps({'code':0,'msg':'Success'}) # 登录成功
            else:
                # 用户被禁用
                web.header('Content-Type', 'application/json')
                return json.dumps({'code':-2,'msg':'用户已被禁用'})
        else:
            # 用户名或密码错误
            web.header('Content-Type', 'application/json')
            return json.dumps({'code':-3,'msg':'用户名或密码错误'})

class Logout:
    def GET(self):
        uid = getCookie('Username')
        token = getCookie('Token')
        sidName = getCookie('xk_session')
        if uid and token and sidName:
            uid = decryptUID(uid)
            #sfile = 'session/' + sidName
            # 删除会话文件，貌似kill方法会把sessionID文件干掉
            #try:
            #    os.remove(sfile)
            #except Exception,e:
            #    print "Session File Error: ",Exception,":",e
            # 设置cookies的status为no
            try:
                db.query('''update login_logs set status="no" where uid="%s" and token="%s"''' % (uid,token))
            except Exception,e:
                print "MySQL Error: ",Exception,":",e
        web.setcookie('Username', '88888888', -1)
        web.setcookie('Token', '88888888', -1)
        web.config._session.kill()
        raise web.seeother("/")

# 测试页面
class Test:
    def GET(self):
        if getLogin():
            SID = getLogin()['SID']
            ShowName = getLogin()['ShowName']
            #print "ShowName: " + ShowName       
            return render.test(ShowName=ShowName,uid=SID)
        else:
            return web.seeother("/login")
