#!/usr/bin/env python
#-*- coding:utf-8 -*-
from main import *

# Redis Instances List
class Index:
    def GET(self):
        if getLogin():
            SID = getLogin()['SID']
            ShowName = getLogin()['ShowName']
            try:
                #getSQL = db.query('''
                #                  select r.id,h.priip1 as ip,port,conf,size,master,slave,r.cdate,r.mdate,u1.nickname as creator,u2.nickname as editor,r.status,r.comment
                #                  from project_redis as r
                #                  left join hosts as h on r.hid=h.id
                #                  left join users as u1 on r.creator=u1.id
                #                  left join users as u2 on r.editor=u2.id
                #                  order by ip''')
                getSQL = db.query('''
                                   select r.id,h.priip1 as ip,r.port,r.conf,r.size,concat(h2.priip1,':',r2.port) as master,concat(h3.priip1,':',r3.port) as slave,r.cdate,r.mdate,u1.nickname as creator,u2.nickname as editor,r.status,r.comment
                                   from project_redis as r
                                   left join hosts as h on r.hid=h.id
                                   left join users as u1 on r.creator=u1.id
                                   left join users as u2 on r.editor=u2.id
                                   left join project_redis as r2 on r.master=r2.id
                                   left join hosts as h2 on r2.hid=h2.id
                                   left join project_redis as r3 on r.slave=r3.id
                                   left join hosts as h3 on r3.hid=h3.id
                                   order by ip,port''')
            except Exception,e:
                print "MySQL Error: ",Exception,":",e
                return "Database Error"
            return render.redis(ShowName=ShowName,uid=SID,redisData=getSQL)
        else:
            web.setcookie('HTTP_REFERER', web.ctx.fullpath, 86400)
            return web.seeother("/login")
            #return render.login()

# 获取所有Redis实例的id,ip,port,以list形式返回
def getAllRedis():
    try:
        # 注释了的这条是把ip和port合并起来了的
        #getRs = db.query('''select r.id,concat(h.priip1,':',r.port) as ip from project_redis as r left join hosts as h on r.hid=h.id order by ip,port''')
        getRs = db.query('''select r.id,h.priip1 as ip,r.port from project_redis as r left join hosts as h on r.hid=h.id order by ip,port''')
    except:
        #return None
        # 上面的return注释是屏蔽错误返回
        return [{'id':'0','ip':'localhost','port':'6379'}]
    if getRs:
        Rs = []
        for i in getRs:
            #Rs.append({'id':i.id,'ip':i.ip})
            Rs.append({'id':i.id,'ip':i.ip,'port':i.port})
        return Rs
    #return None
    return [{'id':'0','ip':'127.0.0.1','port':'6379'}]

# 端口和配置文件重复性检查
def checkUnique(id,hid,conf,port):
   try:
       getSQL = db.query('''select conf,port from project_redis where hid="%s" and id!="%s" and ( conf="%s" or port="%s" )''' % (hid,id,conf,port))
   except Exception,e:
       print "MySQL Error: ",Exception,":",e
       return "Error"
   if getSQL:
       for x in getSQL:
           if str(x.conf) == str(conf):
               # 配置文件同名
               return "Conf.Error"
           if str(x.port) == str(port):
               # 端口冲突
               return "Port.Error"
   else:
       return "ok"

# Redis实例管理: 新增Redis实例
class Add:
    def GET(self):
        if getLogin():
            SID = getLogin()['SID']
            ShowName = getLogin()['ShowName']
            try:
                RedisHost = db.query('''select id,hostname,priip1 from hosts where role=(select id from options where type='role' and value='Redis')''')
            except:
                return "Database Error"
            return render.redis_add(ShowName=ShowName,uid=SID,RedisHost=RedisHost,RedisIns=getAllRedis())
        else:
            web.setcookie('HTTP_REFERER', web.ctx.fullpath, 86400)
            return web.seeother("/login")

    def POST(self):
        if getLogin() is False:
            web.ctx.status = '401 Unauthorized'
            return '401 - Unauthorized\n'
        i = web.input()
        # 重复数据检测
        checkAnswer = checkUnique(i.id,i.hid,i.conf,i.port)
        if checkAnswer != 'ok':
            return checkAnswer
        # 插入数据
        try:
            db.query('''insert into project_redis (hid,port,conf,size,master,slave,cdate,creator,editor,status,comment) values ("%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s")''' % (i.hid,i.port,i.conf,i.size,i.master,i.slave,i.cdate,getLogin()['SID'],getLogin()['SID'],i.status,i.comment))
        except Exception,e:
            print "MySQL Error: ",Exception,":",e
            return "Error"
        # 更新主从关系
        if int(i.master) != 0 or int(i.slave) != 0:
            # 获取当前插入的记录的ID
            curID = db.query('''select id from project_redis where hid="%s" and port="%s"''' % (i.hid,i.port))
        if int(i.master) != 0 and int(i.slave) == 0 and curID:
            # 新增的实例，设置主服务器，而从为0，那么该机器即为从，更新主服务器的slave的值为当前实例的id
            db.query('''update  project_redis set slave="%s",editor="%s",mdate=now() where id="%s"''' % (curID[0].id,getLogin()['SID'],i.master))
        elif int(i.slave) != 0 and int(i.master) == 0 and curID:
            # 新增的实例，设置从服务器，而主为0，那么该机器机位主，更新从服务器的master的值为当前实例的id
            db.query('''update  project_redis set master="%s",editor="%s",mdate=now() where id="%s"''' % (curID[0].id,getLogin()['SID'],i.slave))
        elif int(i.master) == 0 and int(i.slave) == 0:
            return "Add.True"
        else:
            return "forbidden"
            # Bug: 如果被添加的主或者从已经配置过主从，即master或者slave不为0，那么记录被覆盖
        # 返回插入成功响应
        return "Add.True"

# Redis 实例修改
class Edit:
    def GET(self):
        if getLogin():
            SID = getLogin()['SID']
            ShowName = getLogin()['ShowName']
            g = web.input()
            try:
                getRIns = db.query('''
                    select r.id,r.hid,h.priip1 as ip,r.port,r.conf,r.size,r.master,r.slave,r.cdate,r.mdate,u1.nickname as creator,u2.nickname as editor,r.status,r.comment
                    from project_redis as r
                    left join hosts as h on r.hid=h.id
                    left join users as u1 on r.creator=u1.id
                    left join users as u2 on r.editor=u2.id
                    where r.id="%s"''' % g.id)
            except:
                return "Database Error"
            if getRIns:
                return render.redis_edit(ShowName=ShowName,uid=SID,RedisIns=getAllRedis(),curRs=getRIns[0])
            else:
                # 匹配无记录返回
                return "No Record！"
        else:
            web.setcookie('HTTP_REFERER', web.ctx.fullpath, 86400)
            return web.seeother("/login")

    def POST(self):
        if getLogin() is False:
            web.ctx.status = '401 Unauthorized'
            return '401 - Unauthorized\n'
        p = web.input()
        # 重复数据检测
        checkAnswer = checkUnique(p.id,p.hid,p.conf,p.port)
        if checkAnswer != 'ok':
            return checkAnswer
        # 若无重复数据,则更新数据
        try:
            db.query('''
                update project_redis set port="%s",conf="%s",size="%s",master="%s",slave="%s",editor="%s",mdate=now(),status="%s",comment="%s" where id="%s"
                ''' % (p.port,p.conf,p.size,p.master,p.slave,getLogin()['SID'],p.status,p.comment,p.id))
        except Exception,e:
                print "MySQL Error: ",Exception,":",e
                return 'Eorror'
        return 'Edit.True'
