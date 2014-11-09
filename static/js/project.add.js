function createXmlHttp() {
	var xmlHttp = null;
	try {
		//Firefox, Opera 8.0+, Safari
		xmlHttp = new XMLHttpRequest();
	} catch (e) {
		//IE
		try {
			xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
	}
	return xmlHttp;
}

function submitForm(formId) {
	var xmlHttp = createXmlHttp();
	if(!xmlHttp) {
		alert("您的浏览器不支持AJAX！");
		return 0;
	}
	// 定义端口匹配规则
	    var portExp = /^[1-9]*[1-9][0-9]*$/
        var F = document.getElementById(formId)
        var lang = document.getElementById("lang")
        var lang = lang.options[lang.selectedIndex]
        var type = document.getElementById("type")
        var type = type.options[type.selectedIndex]
        var status = document.getElementById("status")
        var status = status.options[status.selectedIndex]
        var isPublic = document.getElementById("isPublic")
        var isPublic = isPublic.options[isPublic.selectedIndex]
        var name = F.name
        var cname = F.cname
        var domain = F.domain
        var port = F.port
        var cdate = F.cdate
        var man = F.man
        var developer = F.developer
        var directory = F.directory
        var relation = F.relation
        var comment = F.comment
        
        if(name.value=='')
           {
               alert('请输入项目名称！');
               name.focus();
               return false;
           }
        if(cname.value=='')
           {
               alert('请输入项目标识！');
               cname.focus();
               return false;
           }
        if(domain.value=='')
           {
               alert('请输入域名！');
               domain.focus();
               return false;
           }
        if(port.value.match(portExp)==null)
           {
               alert('端口不合法！');
               port.focus();
               return false;
           }
        if(lang.value=='0')
           {
               alert('请选择开发框架！');
               document.getElementById("lang").focus();
               return false;
           }
        if(isPublic.value=='0')
           {
               alert('请选择是否公共服务！');
               document.getElementById("isPublic").focus();
               return false;
           }
        if(directory.value=='')
           {
               alert('请输入项目目录！');
               directory.focus();
               return false;
           }
        if(man.value=='')
           {
               alert('请输入接口人！');
               man.focus();
               return false;
           }
        if(developer.value=='')
           {
               alert('请输入开发者！');
               developer.focus();
               return false;
           }

	var e = document.getElementById(formId);
	var url = e.action;
	var inputs = e.elements;
	var postData = "name="+name.value+"&cname="+cname.value+"&type="+type.value+"&domain="+domain.value+"&port="+port.value+"&lang="+lang.value+"&public="+isPublic.value+"&status="+status.value+"&cdate="+cdate.value+"&man="+man.value+"&comment="+comment.value+"&developer="+developer.value+"&directory="+directory.value+"&relation="+relation.value;
	xmlHttp.open("POST", url, true);
	xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); 
	xmlHttp.send(postData);
	xmlHttp.onreadystatechange = function() {
		if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
			//tip.innerHTML = xmlHttp.responseText;
			var PostAnswer=xmlHttp.responseText;
			            var rt = eval(PostAnswer);
                        if(rt[0]=="true")   //跳转到该项目配置界面
                            {
                            alert("添加成功！");
                            var purl = "/project/config?pid=" + rt[2]; 
                            window.location.href=purl;
                            //window.location.href="/project";
                            }
                        else if(rt[0]=="repeat") {
	                        alert("啊噢，域名和端口重复！\n项目：" + rt[1] + "\n域名：" + rt[2]);
	                        document.getElementById("domain").focus();
                        }
                        else {
                            alert("...::>_<::...\n错误：可能数据库挂了");
                            //document.userForm.reset();
                            document.getElementById("name").focus();
                            }
		    }
	        }
}

function resetForm() {
	document.getElementById("projectForm").reset();
	document.getElementById("name").focus();
}

