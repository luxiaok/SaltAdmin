#!/usr/bin/env python
#-*- coding:utf-8 -*-
from main import *
import salt

# salt_status
class Status:
    @Check_Login
    def GET(self):
        sData = getLogin()
        SID = sData['SID']
        ShowName = sData['ShowName']
        return render.salt_status(ShowName=ShowName,uid=SID)

    @Check_Login
    def POST(self):
	p = web.input()
        local = salt.client.LocalClient()
        msl = local.cmd('*',['grains.items','cmd.run'],[[],['cat /proc/uptime /proc/loadavg | xargs echo']])
        x = 1
        rt = ""
        for i in msl:
            G = msl[i]['grains.items']
            U = msl[i]['cmd.run'].split()
            uptime = format_timestamp(U[0])
            load = "%s %s %s" % ( U[2], U[3], U[4] )
            if G['ipv4'][0] == '127.0.0.1':
                ip = G['ipv4'][1]
            else:
                ip = G['ipv4'][0]
            mem = G['mem_total']
            #mem = int(mem)
            if mem > 1000:
                mem = mem / 1000
                mem = "%d GB" % mem
            else:
                mem = "%d MB" % mem
            rt += '''
		<tr class="dataline">
			<td>%s</td>
			<td>%s</td>
			<td>%s</td>
			<td>%s %s</td>
			<td>%s</td>
			<td>None</td>
			<td>%s</td>
			<td>%s</td>
			<td>%s</td>
			<td>%s</td>
			<td>%s</td>
			<td>%s</td>
			<td><font color="green" name="host_status">在线</font></td>
			<td>
			<a href="javascript:void(0)" title="关闭%s" onClick="return confirm('啊噢，您权限不够！');">关机</a> | 
			<a href="javascript:void(0)" title="重启%s" onClick="return confirm('啊噢，你不能随便重启机器！');">重启</a> | 
			<a href="javascript:void(0)" title="查看%s的监控数据" onClick="return confirm('监控功能正在开发~ing~~');">监控</a></td>
		</tr>
            ''' % ( x, i, ip, G['os'], G['osrelease'], G['saltversion'], mem, uptime, load, G.get('role','General'), G.get('manufacturer'), G.get('productname'), i, i, i )
            x += 1
        #print rt
        return rt

# CMD
class Cmd:
    CMD = [
        'cmd.run', 'cmd.script', 'cp.get_dir', 'cp.get_file', 'cp.get_url', 'cron.ls', 
        'disk.usage',
        'grains.item', 'grains.items', 
        'network.interfaces',
        'service.status', 'service.start', 'service.restart', 'service.get_all', 
        'state.running', 'state.sls', 'state.highstate', 
        'status.uptime', 'status.meminfo', 
        'system.halt', 'system.init', 'system.poweroff', 'system.reboot', 'system.shutdown', 
        'test.ping'
    ]
    @Check_Login
    def GET(self):
        sData = getLogin()
        SID = sData['SID']
        ShowName = sData['ShowName']
        return render.salt_cmd(ShowName=ShowName,uid=SID,cmds=Cmd.CMD)

    @Check_Login
    def POST(self):
	c = web.input()
        fun = c.fun
        arg = c.arg
        tgt = c.tgt
        expr_form = c.expr_form
        timeout = c.timeout
        if timeout.isdigit():
            timeout = int(timeout)
        else:
            timeout = None
        #print "Target: %s  Fun: %s  Arg: %s" % ( str(tgt), str(fun), str(arg) )
        Arg = [arg]
        local = salt.client.LocalClient()
        FL = Cmd.CMD
        if fun in FL:
            if fun in ['disk.usage','network.interfaces','grains.items','test.ping','state.running','status.meminfo','status.uptime','service.get_all','system.halt','system.init','system.poweroff','system.reboot','system.shutdown']:
                Arg = []
            elif fun in ['cp.get_dir', 'cp.get_file', 'cp.get_url', 'cron.ls']:
                Arg = arg.split()
            elif fun == 'cmd.script':
                a = arg.split()
                a1 = a[0]
                a2 = ' '.join(a[1:])
                Arg = [a1,a2]
            try:
                rt = local.cmd(tgt=tgt,fun=fun,arg=Arg,timeout=timeout,expr_form=expr_form)
                rt_color = ['green','Success']
            except Exception,e:
                print "SaltStack Exception: ",Exception,":",e
                rt_color = ['red','Failed']
            x = 1
            r = ""
            for i in rt:
                r0 = rt[i]
                if r0 is False or r0 is None:
                    rt_color = ['red','Failed']
                elif isinstance(r0,str):
                    r0 = r0.replace('\n','<br />')
                elif isinstance(r0,dict):
                    r1 = ''
                    for j in r0:
                        if isinstance(r0[j],dict):
                            r1 += "<font color='green'><b>%s:</b></font><br />" % j
                            for z in r0[j]:
                                #if isinstance(r0[j][z],list) and len(r0[j][z]) == 1 :
                                if isinstance(r0[j][z],list):
                                    r1 += "<p class='in2'><font color='green'><b>--- %s:</b></font></p>" % z
                                    for ii in r0[j][z]:
                                        if isinstance(ii,dict):
                                            #r1 += "<p class='in2'><font color='green'><b>%s:</b></font></p>" % ii
                                            for iii in ii:
                                                 r1 += "<p class='in4'><font color='green'>%s: </font> %s</p>" % ( iii, ii[iii] )
                                        else:
                                            r1 += "<p class='in4'>%s</p>" % ii
                                elif isinstance(r0[j][z],dict):
                                    r1 += "<p class='in2'><font color='green'><b>--- %s:</b></font> %s</p>" % z
                                    for zz in r0[j][z]:
                                        r1 += "<p class='in4'>%s</p>" % r0[j][z][zz]
                                else:
                                    r1 += "<p class='in2'><font color='green'><b>--- %s:</b></font> %s</p>" % ( z, r0[j][z] )
                        elif isinstance(r0[j],list):
                            r1 += "<font color='green'><b>%s:</b></font><br />" % j
                            if len(r0[j]) <= 10 :
                                for h in r0[j]:
                                    r1 += "<p class='in4'>%s</p>" % h
                            else:
                                r1 += "<p class='in4'>%s</p>" % r0[j]
                        else:
                            r1 += "<font color='green'><b>%s:</b></font> %s<br />" % ( j, r0[j] )
                    r0 = r1
                elif isinstance(r0,list):
                    r1 = ''
                    for j in r0:
                        r1 += "%s<br />" % j
                    r0 = r1
                r += '''
                    <tr class="dataline">
                        <td>%d</td>
                        <td>%s</td>
                        <td><div style="vertical-align:middle; display:table; text-align:left; margin:0 auto;">%s</div></td>
                        <td><font color=%s>%s</font></td>
                    </tr>
                ''' % ( x, i, r0, rt_color[0], rt_color[1] )
                x += 1
            #return r
        else:
            r = "<tr><td>1</td><td>%s</td><td><font color='red'><b>%s :</b> </font> 请选择执行模块 ...</td><td><font color='red'>Failed</font></td>" \
                % ( str(tgt), str(fun) )
            #return "<b>CMD:</b> %s <b>Arg:</b> %s <b>Target:</b> %s" % ( c.fun, c.arg, c.tgt )
        #print "r = %s" % r
        return r
