#!/usr/bin/env python
#-*- coding:utf-8 -*-
from main import *
import os
import platform
import salt.version
import salt
import salt.key
import psutil
import dmidecode
import json

class LocalInfo:
    def local_uptime(self):
        f = open('/proc/uptime','r')
        r = f.read()
        u = r.split()
        f.close()
        uptime = int(float(u[0]))
        return uptime

    def net_stat(self):
        net = {}
        f = open("/proc/net/dev")
        lines = f.readlines()
        f.close()
        i = 1
        for line in lines:
            if i < 3 :
               i += 1
               continue
            con = line.split(':')
            name = con[0].split()[0]
            var = con[1].split()
            net[name] = var
            i += 1
        return net

    def process_num(self):
        i = 0
        for j in os.listdir('/proc'):
            if j.isdigit():
                i += 1
        return i

    def login_user_num(self):
        p = os.popen('who | wc -l')
        return p.read().split()[0]

    def cpu_used(self):
        return "%.1f" % psutil.cpu_percent(0.1)

    def cpu_nums(self):
        cpu_physical_num = psutil.cpu_count(logical=False)
        cpu_logical_cores = psutil.cpu_count() # 返回CPU逻辑核数量
        return {'cpu_physical_num':cpu_physical_num, 'cpu_logical_cores':cpu_logical_cores}

    def manu(self):
        info = dmidecode.system()
        if len(info) > 0 :
            for i in info :
                try:
                    if info[i]['dmi_type'] == 1 :
                        Manufacturer = info[i]['data']['Manufacturer']
                        Product_Name = info[i]['data']['Product Name']
                except Exception,e:
                    print "Error: ",Exception,":",e
                    Manufacturer = 'General'
                    Product_Name = 'PC'
        else:
            Manufacturer = 'General'
            Product_Name = 'PC'
        m = {'Manufacturer':Manufacturer,'Product_Name':Product_Name}
        return m


Local = LocalInfo()

# 管理中心
class Dashboard:
    @Check_Login
    def GET(self):
        sData = getLogin()
        #SID = sData['SID']
        #ShowName = sData['ShowName']
        #print sData            
        #print "ShowName: " + ShowName
        r = os.popen("ip a | grep inet | grep -Ev 'inet6|127.0.0.1' | awk -F'[ /]+' '{print $3}'")
        r = r.read()
        ip = r.split()
        if len(ip) > 1:
            ip = ', '.join(ip)
        else:
            ip = ip[0]
        # Get OS
        OS = platform.linux_distribution()
        if 'Red Hat Enterprise Linux Server' in OS:
            os_name = 'RHEL'
        else:
            os_name = OS[0]
        os_version = OS[1]
        #os_releaselevel = OS[2]
        os_arch = platform.architecture()
        os_type = platform.machine()
        os_info = os_name + ' ' + os_version + ' ' + os_type
        # Get Disk
        d = os.statvfs('/')
        da = d.f_frsize * d.f_blocks / 1024.0 / 1024 / 1024
        df = d.f_frsize * d.f_bavail / 1024.0 / 1024 / 1024
        du = ( d.f_blocks - d.f_bavail ) * d.f_frsize / 1024.0 / 1024 / 1024
        dp = ( d.f_blocks - d.f_bavail ) * 100 / float(d.f_blocks)
        #dp = d.f_bfree * 100 / float(d.f_blocks)
        da = "%.2f" % da
        df = "%.2f" % df
        du = "%.2f" % du
        dp = int(dp)
        # Get Loadavg
        f = open('/proc/loadavg')
        l = f.read().split()
        f.close()
        loadavg_1 = l[0]
        loadavg_5 = l[1]
        loadavg_15 = l[2]
        # Get Memory
        f = open('/proc/meminfo')
        m = f.readlines()
        f.close()
        mem = {}
        for n in m:
            if len(n) < 2 : continue
            name = n.split(':')[0]
            var = n.split()[1]
            mem[name] = int(var) / 1024
        mem['MemUsed'] = mem['MemTotal'] - mem['MemFree'] - mem['Buffers'] - mem['Cached']
        # Get Net Stat
        net = Local.net_stat()
        net_in = 0
        net_out = 0
        for i in net:
            if i == 'lo':continue
            net_in += int(net[i][0])
            net_out += int(net[i][8])
        net_in = net_in / 1024 / 1024
        net_out = net_out / 1024 /1024
        #
        manu = Local.manu()
        cpu_num = Local.cpu_nums()
        LocalData = {
            'uptime': format_timestamp(Local.local_uptime()), 
            'ip':ip, 
            'hostname':platform.node(), 
            'os':os_info,
            'disk_all':da, 
            'disk_free':df, 
            'disk_used':du, 
            'disk_used_p':dp,
            'loadavg_1':loadavg_1,
            'loadavg_5':loadavg_5,
            'loadavg_15':loadavg_15,
            'salt_version':salt.version.__version__,
            'mem_total':mem['MemTotal'],
            'mem_free':mem['MemFree'],
            'mem_used':mem['MemUsed'],
            'mem_used_p':mem['MemUsed'] * 100 / mem['MemTotal'],
            'net_in':net_in,
            'net_out':net_out,
            'cpu_physical_num':cpu_num['cpu_physical_num'],
            'cpu_logical_cores':cpu_num['cpu_logical_cores'],
            'process_num':Local.process_num(),
            'login_user_num':Local.login_user_num(),
            'cpu_percent':Local.cpu_used(),
            'Manufacturer':manu.get('Manufacturer'),
            'Product_Name':manu.get('Product_Name'),
        }
        return render.dashboard(MyData=sData,LD=LocalData)

# 首页加载数据
class IndexData:
    def salt_minions(self):
        __opts__ = salt.config.client_config('/etc/salt/master')
        mykey = salt.key.Key(__opts__)
        K = mykey.list_keys()
        keys_ok = len(K['minions'])
        keys_rej = len(K['minions_rejected'])
        keys_pre = len(K['minions_pre'])
        local = salt.client.LocalClient()
        rt = local.cmd('*','test.ping',timeout=1)
        minions_online = len(rt)
        sm = {'keys_ok':keys_ok, 'keys_rej':keys_rej, 'keys_pre':keys_pre, 'online':minions_online, 'offline':keys_ok-minions_online}
        return sm

    @Check_Login
    def GET(self):
        rt_data = {}
        rt_data.update(self.salt_minions())
        web.header('content-type','text/json')
        return json.dumps(rt_data)

# 选项管理
class Options:
    def GET(self):
        if getLogin():
            sData = getLogin()
            SID = sData['SID']
            ShowName = sData['ShowName']
            #print sData            
            #print "ShowName: " + ShowName
            #return render.options(ShowName=ShowName,uid=SID)
            g = db.query('''select * from options order by type,value''')
            #op = db.query('''select * from options where type="option"''')
            OpsData = []
            SelectType = []
            for i in g:
                if str(i.type) == 'option':
                    SelectType.append({'value':i.value,'comment':i.comment})
                OpsData.append({'id':i.id,'type':i.type,'value':i.value,'comment':i.comment,'status':i.status})
            #for i in op:
            #    SelectType.append({'value':i.value,'comment':i.comment})
            return render.options(ShowName=ShowName,uid=SID,OpsData=OpsData,SelectType=SelectType)
        else:
            web.setcookie('HTTP_REFERER', web.ctx.fullpath, 86400)
            return web.seeother("/login")

    def POST(self):
        if getLogin() is False:
            web.ctx.status = '401 Unauthorized'
            return '401 - Unauthorized\n'
        i = web.input()
        OpsID = i.id
        OpsType = i.type
        OpsValue = i.value
        OpsComment = i.comment
        OpsStatus = i.status
        #print "Ops: " + OpsType + OpsValue
        if OpsID == "none":
            db.query('''insert into options(type,value,comment,status)values("%s","%s","%s","%s")''' % (OpsType,OpsValue,OpsComment,OpsStatus))
        else:
            db.query('''update options set type="%s",value="%s",comment="%s",status="%s" where id="%s"''' % (OpsType,OpsValue,OpsComment,OpsStatus,OpsID))
        return web.seeother("/admin/options")
        #return render('alert("操作成功！");window.location.href="/admin/options";')
