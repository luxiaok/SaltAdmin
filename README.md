SaltAdmin
=========

![SaltAdmin](https://github.com/luxiaok/SaltAdmin/raw/master/static/images/SaltAdminLogo.jpg)

基于[SaltStack](https://github.com/saltstack/salt)的自动化运维平台

Designed By [Xiaok](http://github.com/luxiaok)


### 运维技术圈（微信扫一扫） ###

![运维技术圈](https://github.com/luxiaok/SaltAdmin/raw/master/static/images/ops_circle_qrcode.jpg)

>也可以微信搜索 **运维技术圈**

### 技术交流QQ群 ###

**459457262**

>加群时请注明来自 **Github**


## 一、环境说明 ##
* 系统平台：RHEL/CentOS 6.x | Ubuntu 12.04+
* [SaltStack](https://github.com/saltstack/salt) >= 2014.7.0
* [Python](http://www.python.org)：2.6.6/2.7.8
* [Webpy](http://webpy.org)：0.37+
* [Mako](http://www.makotemplates.org/)：0.9.1/1.0.0+
* [MySQL](http://www.percona.com/)：Percona-Server 5.5.36
* [MySQL-python](http://pypi.python.org/pypi/MySQL-python)：1.2.5+
* [uWSGI](http://projects.unbit.it/downloads/uwsgi-2.0.6.tar.gz)：2.0.6 (Not Limit)
* [Nginx](http://nginx.org/download/nginx-1.6.0.tar.gz)：1.4.7 (Not Limit)

说明：

* (1).RHEL/CentOS支持6.x系列，7.0以上暂未测试(实际生产环境7.x系列还没成为主流)
* (2).uWSGI和Nginx作为Web容器是可选的环境，可以不部署


## 二、安装 ##

### 1.Webpy ###
* wget http://webpy.org/static/web.py-0.37.tar.gz
* tar zxf web.py-0.37.tar.gz
* python setup.py install

### 2.Mako ###
* easy_install -Z mako

### 3.MySQLdb ###
* yum install MySQL-python

### 4.SaltStack ###
RedHat/CentOS 6 系列<br>
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
* psutil  ## 系统自带的版本过低，使用pip或者easy_install安装最新版

安装方法：使用系统自带的包进行安装即可


## 四、初始化信息 ##
* 会话：项目目录下新建session目录，用于保存会话
* 启动：python run.py
* 端口：8080
* 用名：admin
* 密码：admin


## 五、截图预览 ##

### 登录 ###
![Login](https://github.com/luxiaok/SaltAdmin/raw/master/screenshot/login.png)

### 控制中心 ###
![Dashboard](https://github.com/luxiaok/SaltAdmin/raw/master/screenshot/dashboard.png)

### 监控 ###
![Monitor](https://github.com/luxiaok/SaltAdmin/raw/master/screenshot/monitor.png)

### 设备管理 ###
![Device](https://github.com/luxiaok/SaltAdmin/raw/master/screenshot/device.png)
