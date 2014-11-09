#!/usr/bin/env python
#-*- coding:utf-8 -*-
urls = (
        '/(|login|index)/?',         'view.index.Login',      # 匹配：/,/index,/index/,/login,/login/,但是login函数要做冗余参数处理，还不知道为什么
        '/logout',                   'view.index.Logout',
        '/dashboard/?',              'view.adminCenter.Dashboard',  # /? 匹配最后面的斜杠，可有可无
        '/dashboard/IndexData',      'view.adminCenter.IndexData',  # 加载首页数据url
        '/project/?',                'view.project.Index',
        '/project/add/?',            'view.project.Add',
        '/project/config',           'view.project.Config',
        '/users/?',                  'view.users.Index',
        '/users/add/?',              'view.users.Add',
        '/users/del',                'view.users.Delete',
        '/users/enable',             'view.users.Enable',
        '/users/disable',            'view.users.Disable',
        '/users/edit',               'view.users.Edit',
        '/users/password',           'view.users.Password',
        #'^/users/([^/]+)$',         'view.users.%s',
        '/hosts/?',                  'view.hosts.Index',
        '/hosts/add/?',              'view.hosts.Add',
        '/hosts/edit',               'view.hosts.Edit',
        '/hosts/redis/?',            'view.redisAdmin.Index',
        '/hosts/redis/add',          'view.redisAdmin.Add',
        '/hosts/redis/edit',         'view.redisAdmin.Edit',
        '/admin/redis',              'view.adminCenter.Redis',
        '/admin/options',            'view.adminCenter.Options',
        '/monitor/redis',            'view.monitor.M_Redis',
        '/monitor/mysql',            'view.monitor.M_MySQL',
        '/monitor/traffic',          'view.monitor.M_Traffic',
        '/salt/status',              'view.saltAdmin.Status',
        '/salt/cmd',                 'view.saltAdmin.Cmd',
        #'/report',                   'view.report.Index',
        '/report/fault',             'view.report.Fault',
        #'/report/topo',              'view.report.Topo',
        #'/report/wiki',              'view.report.Wiki',
        #'/report/norm',              'view.report.Norm',
        '/test',                     'view.index.Test',
)
