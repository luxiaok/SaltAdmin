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
	
        //var F = document.userForm
        var F = document.getElementById(formId)
        var username = F.username
        var nickname = F.nickname
        var password = F.password
        var password2 = F.password2
        var mobile = F.mobile.value
        var email = F.email.value
        var comment = F.comment.value
        var regdate = F.regdate.value
        //var level = document.getElementByName("level")
        //var status = document.getElementByName("status")
        var level = document.getElementById("level")
        var status = document.getElementById("status")
        if(username.value=='')
           {
               alert('请输入用户名！');
               username.focus();
               return false;
           }
        if(nickname.value=='')
           {
               alert('请输入姓名！');
               nickname.focus();
               return false;
           }
        if(password.value=='')
           {
               alert('请输入密码！');
               password.focus();
               return false;
           }
        if(password.value!==password2.value)
           {
               alert('密码输入不一致！');
               password.focus();
               return false;
           }

	var e = document.getElementById(formId);
	var url = e.action;
	var inputs = e.elements;
	var postData = "username="+username.value+"&nickname="+nickname.value+"&password="+password.value+"&level="+level.options[level.selectedIndex].value+"&status="+status.options[status.selectedIndex].value+"&mobile="+mobile+"&email="+email+"&comment="+comment+"&regdate="+regdate;
	xmlHttp.open("POST", url, true);
	xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); 
	xmlHttp.send(postData);
	xmlHttp.onreadystatechange = function() {
		if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
			//tip.innerHTML = xmlHttp.responseText;
			var PostAnswer=xmlHttp.responseText;
                        if(PostAnswer=="true")   //跳转到用户管理界面
                            {
                            alert("添加成功！");
                            window.location.href="/users";
                            }
                        else if (PostAnswer=="false")
                            {
                            alert("用户已存在！");
                            //$("input[name='reset']").click();
                            document.getElementById('userForm').reset();
                            username.focus();
                            }
                        else if (PostAnswer=="error2")
	                        {
                            alert("无法提交！");
                            //username.focus();
                            }
                        else {
                            alert("服务器出错了噢(┬＿┬)！");
                            //document.userForm.reset();
                            //username.focus();;
                            }
		    }
	        }
}

function KeyDown()  
{
  if(event.keyCode == 13) 
    {   
      event.returnValue = false;  
      event.cancel = true;  
      userForm.submit.click();  
    }
}

function resetForm() {
	document.getElementById('userForm').reset();
	document.getElementById('username').focus();
}

