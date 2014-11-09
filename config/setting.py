#!/usr/bin/env python
#-*- coding:utf-8 -*-
import web
from web.contrib.template import render_mako
from config.database import *
from config.urls import *
#import os

# Debug : True or False
web.config.debug = True

#render = web.template.render("templates/")
render = render_mako(
        directories=['html'],
        #directories=[os.path.join(os.path.dirname(__file__), 'templates').replace('\\','/'),],
        input_encoding='utf-8',
        output_encoding='utf-8',
        default_filters=['decode.utf_8'],
        )

db = web.database(
                 dbn=dbType,
                 db=dbName,
                 host=dbHost,
                 port=dbPort,
                 user=dbUser,
                 pw=dbPass,
                 charset=dbChar
                 )

