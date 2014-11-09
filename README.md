SaltAdmin
=========
基于[Python](http://www.python.org)、[SaltStack](http://www.saltstack.com)和[Webpy](http://webpy.org)的开源运维平台<br>
Desgin By [Xiaok](http://github.com/luxiaok)

## 一、环境说明 ##
* 系统平台：RHEL 6.5 x64 | CentOS 6.5 | Ubuntu 12.04
* [Python](http://www.python.org)：2.6.6/2.7.8
* [Webpy](http://webpy.org)：0.37
* [Mako](http://www.makotemplates.org/)：0.9.1/1.0.0
* [MySQL](http://www.percona.com/)：Percona-Server 5.5.36
* [MySQL-python](http://pypi.python.org/pypi/MySQL-python)：1.2.5
* [uWSGI](http://projects.unbit.it/downloads/uwsgi-2.0.6.tar.gz)：2.0.6
* [Nginx](http://nginx.org/download/nginx-1.6.0.tar.gz)：1.4.7

说明：uWSGI和Nginx作为Web容器是可选的环境，可以不部署

## 二、安装 ##

### 1.webpy ###
* wget http://webpy.org/static/web.py-0.37.tar.gz
* tar zxf web.py-0.37.tar.gz
* python setup.py install

### 2.Mako ###
* easy_install -Z mako

### 3.MySQLdb ###
* yum install MySQL-python

### 4.SaltStack ###
RedHat 6 系列<br>
* rpm -ivh http://mirrors.sohu.com/fedora-epel/6Server/x86_64/epel-release-6-8.noarch.rpm
* yum install salt-master
* yum install salt-minion

Ubuntu 系列<br>
* add-apt-repository -y ppa:saltstack/salt
* apt-get update
* apt-get install salt-master
* apt-get install salt-ssh
* apt-get install salt-minion

### 5.数据库初始化  ###
* 新建数据库saltadmin
* 导入doc目录下的saltadmin.sql文件
* 配置config/database.py


## 三、其他依赖 ##
依赖以下python模块
* python-dmidecode
* psutil<br>
安装方法：使用系统自带的包进行安装即可


## 四、初始化信息 ##
* 启动：python run.py
* 端口：8080
* 用户名：admin
* 密  码：admin

## 五、截图欣赏 ##

### 登录 ###
![Login](https://github.com/luxiaok/SaltAdmin/raw/master/screenshot/login.png)

### 控制中心 ###
![Dashboard](https://github.com/luxiaok/SaltAdmin/raw/master/screenshot/dashboard.png)

### 监控 ###
![Monitor](https://github.com/luxiaok/SaltAdmin/raw/master/screenshot/monitor.png)

### 设备管理 ###
![Device](https://github.com/luxiaok/SaltAdmin/raw/master/screenshot/device.png)

