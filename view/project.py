#!/usr/bin/env python
#-*- coding:utf-8 -*-
from main import *

# 项目管理
class Index:
    def GET(self):
        if getLogin():
            SID = getLogin()['SID']
            ShowName = getLogin()['ShowName']
            #print "ShowName: " + ShowName
            #return render.project(ShowName=ShowName,uid=SID)
            try:
                #pd = db.query('''select * from project_base''')
                pd = db.query('''select p.id,p.name,p.cname,p.domain,p.port,p.public,p.lang,p.man,p.developer,p.directory,p.relation,op.value as type,p.status,u1.nickname as creator,p.cdate,u2.nickname as editor,p.mdate,p.comment
                              from project_base as p
                              left join options as op on p.type=op.id
                              left join users as u1 on p.creator=u1.id
                              left join users as u2 on p.editor=u2.id''')
            except:
                return "服务器(数据库)错误"
            #ProjectData = {}
            #x = 0
            #for i in getSQL:
            #    ProjectData[x] = {"id":i.id,"name":i.name,"mark":i.mark,"domain":i.domain,"fronthost":i.fronthost,"directory":i.directory,"manager":i.manager,"developer":i.developer,"startdate":i.startdate,"idc":i.idc,"status":i.status}
            #    x += 1
            #print ProjectData
            return render.project(ShowName=ShowName,uid=SID,pd=pd)
        else:
            web.setcookie('HTTP_REFERER', web.ctx.fullpath, 86400)
            return web.seeother("/login")

# 添加项目
class Add:
    def GET(self):
        if getLogin():
            SID = getLogin()['SID']
            ShowName = getLogin()['ShowName']
            #print "ShowName: " + ShowName
            # 新增项目时发布机不属于项目属性,因此取消
            #rh = db.query('''select id,priip1 from hosts where role=(select id from options where type='role' and value='Release')''')
            pt = db.query('''select id,value from options where type="project_type"''')
            return render.project_add(ShowName=ShowName,uid=SID,pt=pt)
        else:
            web.setcookie('HTTP_REFERER', web.ctx.fullpath, 86400)
            return web.seeother("/login")

    def POST(self):
        if getLogin() is False:
            web.ctx.status = '401 Unauthorized'
            return '401 - Unauthorized\n'
        p = web.input()
        # 插入域名前，应该有个域名检测，域名应该不能重复
        check = db.query('''select id,name,cname from project_base where domain="%s" and port="%s"''' % (p.domain,p.port))
        if check:
            return '["repeat","%s","%s"]' % (check[0].name,p.domain)
	try:
            db.query('''insert into project_base(
                    name,cname,domain,port,lang,public,directory,relation,developer,man,type,status,comment,cdate,mdate,creator,editor)
                    values("%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s",now(),now(),"%s","%s")
                    ''' % (p.name,p.cname,p.domain,p.port,p.lang,p.public,p.directory,p.relation,p.developer,p.man,p.type,p.status,p.comment,getLogin()['SID'],getLogin()['SID']))
            pid = db.query('''select id from project_base where name="%s" and cname="%s" and domain="%s" and port="%s" and directory="%s"''' % (p.name,p.cname,p.domain,p.port,p.directory))
        except Exception,e:
            # 无法提交，可能是数据库挂了
            print "Error: ",Exception,":",e
            return '["error","database","%s"]' % e
        # 添加成功
        rt = '["true","pid","%s"]' % (pid[0].id)
        #print 'Return Value: ',rt
        return rt

class Config:
    def GET(self):
        if getLogin():
            SID = getLogin()['SID']
            ShowName = getLogin()['ShowName']
            i = web.input()
            #rh = db.query('''select id,priip1 from hosts where role=(select id from options where type='role' and value='Release')''')
            pd = db.query('''select p.id,p.name,p.cname,p.domain,p.port,p.public,p.lang,p.man,p.developer,p.directory,op.value as type,p.status,u1.nickname as creator,p.cdate,u2.nickname as editor,p.mdate,p.comment,p.relation
                              from project_base as p
                              left join options as op on p.type=op.id
                              left join users as u1 on p.creator=u1.id
                              left join users as u2 on p.editor=u2.id
                              where p.id="%s"''' % i.pid)
            s = db.query('''select id,priip1 from hosts where role=(select id from options where value="Web")''')
            sm = []
            for i in s:
                sm.append((i.id,i.priip1))
            return render.project_config(ShowName=ShowName,uid=SID,pd=pd[0],sm=sm)
        else:
            web.setcookie('HTTP_REFERER', web.ctx.fullpath, 86400)
            return web.seeother("/login")

    def POST(self):
        if getLogin() is False:
            web.ctx.status = '401 Unauthorized'
            return '401 - Unauthorized\n'
        i = web.input(bw=[],bwconf=[])
        print "Test Post Data: "
        print i
        print "####################"
        l = len(i)
        print l
        h = '<b>Number of Post Data: ' + str(l) + '</b><br />'
        p = {}
        for x in i:
            p[x] = i[x]
            h += x + ' = ' + str(i[x]) + '<br />'
        print p
        q = []
        q.append({'type':'release','tid':p.pop('release_host'),'conf':p.pop('directory')})
        q.append({'type':'front','tid':p.pop('front'),'port':p.pop('front_port'),'conf':p.pop('front_config')})
        print q
        print p
        return "%s" % h
