#!/usr/bin/env python
#-*- coding:utf-8 -*-
from main import *

# 用户管理
class Index:
    def GET(self):
        if getLogin():
            SID = getLogin()['SID']
            ShowName = getLogin()['ShowName']
            #print "ShowName: " + ShowName       
            #return render.users(ShowName=ShowName)
            try:
               getSQL = db.query('''select u.id,username,nickname,mobile,email,level,u.status,regdate,L.ip as loginhost,L.date as logindate,comment from users as u left join login_logs as L on u.loginfo=L.id where u.id>0''')
            except:
               # 服务器(数据库)错误
               return "Database Error"
            # 获取查询到的数据
            UsersData = {}
            x=0
            for i in getSQL:
                if i.level == 0:
                    level = '管理者'
                else:
                    level = '普通用户'
                if i.status == 'yes':
                    status = '已启用'
                else:
                    status = '已禁用'
                UsersData[x] = {"id":i.id,"username":i.username,"nickname":i.nickname,"mobile":i.mobile,"email":i.email,"level":level,"status":status,"comment":i.comment,"regdate":i.regdate,"loginhost":i.loginhost,"logindate":i.logindate}
                x+=1
            return render.users(ShowName=ShowName,uid=SID,UsersData=UsersData)
        else:
            web.setcookie('HTTP_REFERER', web.ctx.fullpath, 86400)
            return web.seeother("/login")

# 添加用户
class Add:
    def GET(self):
        if getLogin():
            SID = getLogin()['SID']
            ShowName = getLogin()['ShowName']
            #print "ShowName: " + ShowName
            return render.useradd(ShowName=ShowName,uid=SID)
        else:
            web.setcookie('HTTP_REFERER', web.ctx.fullpath, 86400)
            return web.seeother("/login")

    def POST(self):
        if getLogin() is False:
            web.ctx.status = '401 Unauthorized'
            return '401 - Unauthorized\n'
	getPost = web.input()
        #user = 'test'
        #print 'status: ' + getPost.status
        try:
            getSQL = db.query('''select id,username from users where username="%s"''' % (getPost.username))
        except:
            # 服务器(数据库)错误
            return "error"
        if getSQL:
            # 用户已存在
            return "false"
        else:
	    try:
                db.query('''insert into users(username,password,nickname,level,status,mobile,email,comment,regdate)values("%s",md5("%s"),"%s","%s","%s","%s","%s","%s","%s")''' % (getPost.username,getPost.password,getPost.nickname,getPost.level,getPost.status,getPost.mobile,getPost.email,getPost.comment,getPost.regdate))
            except:
                # 无法提交，可能是数据库挂了
                return "error2"
            # 创建用户成功
            return "true"

# 删除用户
class Delete:
    def GET(self):
        if getLogin():
            #SID = getLogin()['SID']
            ShowName = getLogin()['ShowName']
            #print "ShowName: " + ShowName
            getData = web.input()
            id = getData.id
            db.query('''delete from users where id="%s"''' % id)
            return web.seeother("/users")
        else:
            web.setcookie('HTTP_REFERER', web.ctx.fullpath, 86400)
            return web.seeother("/login")

# 禁用用户
class Disable:
    def GET(self):
        if getLogin():
            #SID = getLogin()['SID']
            ShowName = getLogin()['ShowName']
            #print "ShowName: " + ShowName
            getData = web.input()
            id = getData.id
            db.query('''update users set status='no' where id="%s"''' % id)
            return web.seeother("/users")
        else:
            web.setcookie('HTTP_REFERER', web.ctx.fullpath, 86400)
            return web.seeother("/login")

# 启用用户
class Enable:
    def GET(self):
        if getLogin():
            #SID = getLogin()['SID']
            ShowName = getLogin()['ShowName']
            #print "ShowName: " + ShowName
            getData = web.input()
            id = getData.id
            db.query('''update users set status='yes' where id="%s"''' % id)
            return web.seeother("/users")
        else:
            web.setcookie('HTTP_REFERER', web.ctx.fullpath, 86400)
            return web.seeother("/login")

# 编辑
class Edit:
    def GET(self):
        if getLogin():
            SID = getLogin()['SID']
            ShowName = getLogin()['ShowName']
            #print "ShowName: " + ShowName
            getData = web.input()
            uid = getData.id
            getSQL = db.query('''select u.id,username,nickname,mobile,email,level,u.status,regdate,L.ip as loginhost,L.location,L.agent,L.date as logindate,comment from users as u left join login_logs as L on u.loginfo=L.id where u.id="%s"''' % uid)
            ud = getSQL[0]
            UserData = {'id':ud.id,'username':ud.username,'nickname':ud.nickname,'mobile':ud.mobile,'email':ud.email,'level':ud.level,'status':ud.status,'loginhost':ud.loginhost,'location':ud.location,'logindate':ud.logindate,'UA':ud.agent,'regdate':ud.regdate,'comment':ud.comment}
            UA = getUA(UserData['UA'])
            UserData['UA'] = UA
            return render.useredit(ShowName=ShowName,uid=SID,UserData=UserData)
        else:
            web.setcookie('HTTP_REFERER', web.ctx.fullpath, 86400)
            return web.seeother("/login")

    def POST(self):
        if getLogin() is False:
            web.ctx.status = '401 Unauthorized'
            return '401 - Unauthorized\n'
        getPost = web.input()
        cuid = getPost.myuid
        username = getPost.username
        nickname = getPost.nickname
        mobile = getPost.mobile
        email = getPost.email
        comment = getPost.comment
        level = None
        status = None
        if 'level' in getPost:
            level = getPost.level
            #print 'getPost.level Type:',type(getPost['level'])
        if 'status' in getPost:
            status = getPost.status
        try:
            if level and status:
                db.query('''update users set nickname="%s",mobile="%s",email="%s",level="%s",status="%s",comment="%s" where id="%s"''' % (nickname,mobile,email,level,status,comment,cuid))
            else:
                db.query('''update users set nickname="%s",mobile="%s",email="%s",comment="%s" where id="%s"''' % (nickname,mobile,email,comment,cuid))
        except Exception,e:
            print "MySQL Error: ",Exception,":",e
            return "Update Error"
        return '''
               <html lang="zh"><head><meta charset="utf-8" />
               <title>Success</title>
               <script type="text/javascript" lang="javascript">
               alert('\u4fee\u6539\u6210\u529f\uff01');
               window.location.href="/users/edit?id=%s";
               </script></head>
               ''' % cuid
        # 上面的Uicode代码是"修改成功！"

# 修改密码
class Password:
    def POST(self):
        if getLogin() is False:
            web.ctx.status = '401 Unauthorized'
            return '401 - Unauthorized\n'
        p = web.input()
        print 'Post Data For Pass: ',p
        if 'oldpassword' in p:
            # 修改自己的密码要进行原始密码验证
            oldpass = p.oldpassword
            try:
                OldPassInDB = db.query('''select id,password from users where id="%s" and password=md5("%s")''' % (p.myuid,oldpass))
            except:
                return 'error'
            if OldPassInDB:
	        #密码验证成功,开始更新数据
	        try:               
                    db.query('''update users set password=md5("%s") where id="%s"''' % (p.password,p.myuid))
	        except:
	            # 数据库服务器错误
	            return 'error'
	        return 'my.true'
            else:
                # 原始密码验证错误
                return 'oldpass.false'
	else:
	    # 管理员修改其他用户的资料，不进行原始密码验证
	    try:
	        db.query('''update users set password=md5("%s") where id="%s"''' % (p.password,p.myuid))
	    except:
	        # 数据库服务器错误
	        return 'error'
	    return 'true'

# 用户浏览器判断
def getUA(UA):
    if not UA:
        return 'None'
    # IE
    if 'MSIE' in UA:
        # 注意索引异常
        return UA.split('; ')[1]
    elif 'Chrome' in UA:
        return UA.split(' ')[9]
    elif 'Firefox' in UA:
        return UA.split(' ')[7]
    elif 'Safari' in UA:
        return 'Safari'
    else:
        return 'Unknown UserAgent'
