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
	      // 定义IP匹配规则
	      var ipExp = /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;
	      // 定义提交过来的数据
        //var F = document.hostForm
        var F = document.getElementById(formId);
        var id = F.id.value
        var hostname = F.hostname
        var role = document.getElementById("role")
        var role = role.options[role.selectedIndex].value
        var priip1 = F.priip1
        var priip2 = F.priip2
        var pubip1 = F.pubip1
        var pubip2 = F.pubip2
        var model = document.getElementById("model")
        var model = model.options[model.selectedIndex].value
        var cpu = document.getElementById("cpu")
        var cpu = cpu.options[cpu.selectedIndex].value
        var hdd = document.getElementById("hdd")
        var hdd = hdd.options[hdd.selectedIndex].value
        var mem = document.getElementById("mem")
        var mem = mem.options[mem.selectedIndex].value
        var os = document.getElementById("os")
        var os = os.options[os.selectedIndex].value
        var adminip = F.adminip.value
        var rnum = F.rnum.value
        var storagedate = F.storagedate.value
        var type = F.type.value
        var startdate = F.startdate.value
        var idc = document.getElementById("idc")
        var idc = idc.options[idc.selectedIndex].value
        var idctag = document.getElementById("idctag")
        var idctag = idctag.options[idctag.selectedIndex].value
        var snum = F.snum
        var stag = F.stag.value
        var status = document.getElementById("status")
        var status = status.options[status.selectedIndex].value
        var comment = F.comment.value
        
        if(hostname.value=='')
           {
               alert('请输入主机名！');
               hostname.focus();
               return false;
           }
        if(priip1.value=='')
           {
               alert('请输入内网IP地址！');
               priip1.focus();
               return false;
           }
        if(priip1.value.match(ipExp)==null)
          {
               alert('内网IP地址不合法！');
               priip1.focus();
               return false;
          }
          if(priip2.value!='' && priip2.value.match(ipExp)==null)
          {
               alert('内网IP地址2不合法！');
               priip2.focus();
               return false;
          }
          if(pubip1.value!='' && pubip1.value.match(ipExp)==null)
          {
               alert('公网IP不合法！');
               pubip1.focus();
               return false;
          }
          if(pubip2.value!='' && pubip2.value.match(ipExp)==null)
          {
               alert('公网IP地址2不合法！');
               pubip2.focus();
               return false;
          }
        //if(stag.value=='')
        //   {
        //       alert('请输入服务器标签！');
        //       stag.focus();
        //       return false;
        //   }

	var e = document.getElementById(formId);
	var url = e.action;
	var inputs = e.elements;
	var postData = "id="+id+"&hostname="+hostname.value+"&role="+role+"&priip1="+priip1.value+"&priip2="+priip2.value+"&pubip1="+pubip1.value+"&pubip2="+pubip2.value+"&model="+model+"&cpu="+cpu+"&hdd="+hdd+"&mem="+mem+"&os="+os+"&adminip="+adminip+"&rnum="+rnum+"&storagedate="+storagedate+"&type="+type+"&startdate="+startdate+"&idc="+idc+"&idctag="+idctag+"&snum="+snum.value+"&stag="+stag+"&status="+status+"&comment="+comment;
	xmlHttp.open("POST", url, true);
	xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); 
	xmlHttp.send(postData);
	xmlHttp.onreadystatechange = function() {
		if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
			//tip.innerHTML = xmlHttp.responseText;
			var PostAnswer=xmlHttp.responseText;
                        if(PostAnswer=="Add.True")   //跳转到主机管理界面
                            {
                            alert("添加成功！");
                            window.location.href="/hosts";
                            }
                        else if(PostAnswer=="Edit.True")   //跳转到主机管理界面
                            {
                            alert("修改成功！");
                            window.location.href="/hosts";
                            }
                        else if (PostAnswer=="HostnameError")
                            {
                            alert("主机名冲突！");
                            hostname.focus();
                            return false;
                            }
                        else if (PostAnswer=="PriIP1Error")
                            {
                            alert("内网IP地址冲突");
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

function resetForm() {
	document.getElementById('hostForm').reset();
	document.getElementById('hostname').focus();
}

// hosts页面按照条件刷选显示
function onSearch(selectID,row){//js函数开始
	setTimeout(function(){//因为是即时查询，需要用setTimeout进行延迟，让select选定时，再读取
		var storeId = document.getElementById('datalist');//获取table的id标识
		var rowsLength = storeId.rows.length - 1;//表格总共有多少行，这里减1表示去除最后一行footer标题
		//var key = obj.value;//获取输入框的值
        var select = document.getElementById(selectID)
        var key = select.options[select.selectedIndex].value;     //获取select的值
		var searchCol = row;//要搜索的哪一列，这里用变量row

		for(var i=1;i<rowsLength;i++){//按表的行数进行循环，第一行是标题不计算在内，所以i=1，从第二行开始筛选（从0数起）
			var searchText = storeId.rows[i].cells[searchCol].innerHTML;//取得table行，列的值

			if(searchText.match(key)){//用match函数进行筛选，如果input的值，即变量 key的值为空，返回的是true，
				storeId.rows[i].style.display='';//显示行操作，
			}else{
				storeId.rows[i].style.display='none';//隐藏行操作
			}
		}
	},100);//100为延时时间，这里是100毫秒
}