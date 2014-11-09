SaltAdmin
=========
基于[SaltStack](http://www.saltstack.com)的运维平台<br>
Desgin By [Xiaok](http://github.com/luxiaok)

## 一、环境说明 ##
* 系统平台：rhel 6.5 x64
* [Python](http://www.python.org)：2.6.6/2.7.8
* [Webpy](http://webpy.org)：0.37
* [Mako](http://www.makotemplates.org/)：0.9.1/1.0.0
* [uWSGI](http://projects.unbit.it/downloads/uwsgi-2.0.6.tar.gz)：2.0.6
* [Nginx](http://nginx.org/download/nginx-1.6.0.tar.gz)：1.4.7
* [MySQL](http://www.percona.com/)：Percona-Server 5.5.36
* [MySQL-python](http://pypi.python.org/pypi/MySQL-python)：1.2.5

## 二、安装 ##

### 1.webpy ###
* wget http://webpy.org/static/web.py-0.37.tar.gz
* python setup.py install
* ftp://rpmfind.net/linux/epel/6/x86_64/python-webpy-0.37-2.el6.noarch.rpm
* ftp://rpmfind.net/linux/dag/redhat/el6/en/x86_64/dag/RPMS/python-webpy-0.37-1.el6.rf.noarch.rpm

### 2.Mako ###
* easy_install -Z mako
* http://www.makotemplates.org/
* https://pypi.python.org/packages/source/M/Mako/Mako-0.9.1.tar.gz
* https://pypi.python.org/packages/source/M/Mako/Mako-1.0.0.tar.gz
* python setup.py install

## 三、其他依赖 ##
* 依赖以下python模块：
* python-dmidecode、psutil、salt

## 四、截图欣赏 ##

### 登录 ###
![Login](https://github.com/luxiaok/SaltAdmin/raw/master/screenshot/login.png)

### 控制中心 ###
![Dashboard](https://github.com/luxiaok/SaltAdmin/raw/master/screenshot/dashboard.png)

### 监控 ###
![Monitor](https://github.com/luxiaok/SaltAdmin/raw/master/screenshot/monitor.png)

### 设备管理 ###
![Device](https://github.com/luxiaok/SaltAdmin/raw/master/screenshot/device.png)

