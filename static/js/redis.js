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
	    // 定义port匹配规则
	    var portExp = /^[1-9]*[1-9][0-9]*$/;
	    // 定义提交过来的数据
        //var F = document.redisForm
        var F = document.getElementById(formId)
        var id = F.id.value
        if (id=='none') {
            var hid = document.getElementById("hid")
            var hid = hid.options[hid.selectedIndex].value
            var cdate = F.cdate.value
            var mdate = F.mdate.value
            }
        else { 
	        var hid = F.hid.value
            var cdate = 'none'
            var mdate = 'none'
	        }
        var port = F.port
        var conf = F.conf
        var size = F.size
        var sizeunit = document.getElementById("sizeunit")
        var sizeunit = sizeunit.options[sizeunit.selectedIndex].value
        //var size = size.value + sizeunit
        var master = document.getElementById("master")
        var master = master.options[master.selectedIndex].value
        var slave = document.getElementById("slave")
        var slave = slave.options[slave.selectedIndex].value
        var status = document.getElementById("status")
        var status = status.options[status.selectedIndex].value
        var comment = F.comment.value   
        
        if(hid=='0')
           {
               alert('请选择Redis主机');
               //hid.focus();
               document.getElementById("hid").focus();
               return false;
           }
        if(port.value.match(portExp)==null)
          {
               alert('端口不合法！');
               port.focus();
               return false;
          }
        if(conf.value=='')
           {
               alert('请输入实例配置文件路径！');
               conf.focus();
               return false;
           }
        if(size.value=='')
           {
               alert('请输入容量');
               size.focus();
               return false;
           }
        if(master!=0 && slave!=0)
           {
               alert('请检查主从设置！');
               document.getElementById("master").focus();
               return false;
           }

	var e = document.getElementById(formId);
	var url = e.action;
	var inputs = e.elements;
	var postData = "id="+id+"&hid="+hid+"&port="+port.value+"&conf="+conf.value+"&size="+size.value+sizeunit+"&master="+master+"&slave="+slave+"&cdate="+cdate+"&mdate="+mdate+"&status="+status+"&comment="+comment;
	xmlHttp.open("POST", url, true);
	xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); 
	xmlHttp.send(postData);
	xmlHttp.onreadystatechange = function() {
		if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
			//tip.innerHTML = xmlHttp.responseText;
			var PostAnswer=xmlHttp.responseText;
                        if(PostAnswer=="Add.True")   //跳转到Redis实例管理界面
                            {
                            alert("添加成功！");
                            window.location.href="/hosts/redis";
                            }
                        else if(PostAnswer=="Edit.True")   //跳转到Redis实例管理界面
                            {
                            alert("修改成功！");
                            window.location.href="/hosts/redis";
                            }
                        else if (PostAnswer=="Port.Error")
                            {
                            alert("端口冲突！");
                            hostname.focus();
                            return false;
                            }
                        else if (PostAnswer=="Conf.Error")
                            {
                            alert("配置文件同名");
                            priip1.focus();
                            return false;
                            }
                        else if (PostAnswer=="Error")
                           {
                            alert("貌似服务器出错了噢(┬＿┬)！");
                            //document.userForm.reset();
                            //username.focus();;
                            return false;
                            }
                        else  
                           {
                            alert("服务器也木有知道哪儿出错了(┬＿┬)");
                            //document.userForm.reset();
                            //username.focus();
                            return false;
                            }
		    }
	        }
}

function resetForm(focusID) {
	document.getElementById('redisForm').reset();
	document.getElementById(focusID).focus();
}