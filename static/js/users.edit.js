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

// 获取单选框的值
function GetRadioValue(RadioName){
    var obj = document.getElementsByName(RadioName);
    if(obj!=null){
        var i;
        for(i=0;i<obj.length;i++){
            if(obj[i].checked){
                return obj[i].value;            
            }
        }
    }
    return null;
}

function submitForm(formId) {
	var xmlHttp = createXmlHttp();
	if(!xmlHttp) {
		alert("您的浏览器不支持AJAX！");
		return 0;
    }
        //var F = document.passForm;
        var F = document.getElementById(formId);
        var myuid = F.myuid;
        //var username = F.username;
        //var nickname = F.nickname;
        var oldpassword = F.oldpassword;
        var password = F.password;
        var password2 = F.password2;
        //var mobile = F.mobile.value;
        //var email = F.email.value;
        //var status = GetRadioValue("status");
        //var level = GetRadioValue("level");
        //var comment = F.comment.value;
        //if(nickname.value=='')
        //   {
        //       alert('请输入姓名！');
        //       nickname.focus();
        //       return false;
        //   }
        // 修改自己的密码的时候需要确认原始密码
        // 如果是管理员修改其他成员的密码就不需要确认原始密码了
        // 可用于寻找管理员找回密码
        if (oldpassword)
        {
	        if(oldpassword.value=='')
               {
               alert('请输入原始密码！');
               oldpassword.focus();
               return false;
               }  
        }
        if(password.value=='')
           {
               alert('请输入新密码！');
               password.focus();
               return false;
           }
        if(password2.value=='')
           {
               alert('请再次输入新密码！');
               password2.focus();
               return false;
           }
        if(password.value!==password2.value)
           {
               alert('新密码输入不一致！');
               password.focus();
               return false;
           }

	var e = document.getElementById(formId);
	var url = e.action;
	var inputs = e.elements;
	// 如果修改自己的属性，提交数据则不同
	if (oldpassword)
	    var postData = "myuid="+myuid.value+"&oldpassword="+oldpassword.value+"&password="+password.value;
	else
	    var postData = "myuid="+myuid.value+"&password="+password.value;
	xmlHttp.open("POST", url, true);
	xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); 
	xmlHttp.send(postData);
	xmlHttp.onreadystatechange = function() {
		if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
			//tip.innerHTML = xmlHttp.responseText;
			var PostAnswer=xmlHttp.responseText;
                        if(PostAnswer=="my.true") {
	                        // 用户修改自己的密码成功后不跳转
                            alert("修改成功！");
                            //修改成功不跳转
                            //$("input[name='reset']").click();
                            //window.location.href="/users";
                            // 修改自己的密码成功后刷新当前页面
                            location.reload();
                            }
                        else if(PostAnswer=="true") {
                            alert("修改成功！");
                            //管理员修改别的用户资料，成功后跳转
                            //$("input[name='reset']").click();
                            window.location.href="/users";
                            }
                        else if (PostAnswer=="oldpass.false") {
                            alert("原始密码错误！");
                            $("a[name='reset']").click();
                            oldpassword.focus();
                            }
                        else if (PostAnswer=="error") {
                            alert("数据库可能挂了！");
                            //document.userForm.reset();
                            //document.getElementById('username').focus();
                            //return false;
                            }
                        else {
                            alert("不知道哪出错了噢！");
                            //document.userForm.reset();
                            //document.getElementById('username').focus();
                            //return false;
                            }
		    }
	    }
}

// 重设表单
function resetForm(formID,focusID) {
	document.getElementById(formID).reset();
	//document.formID.reset();
	document.getElementById(focusID).focus();
}

// 切换“用户信息”和“密码修改”模式
function changeMode(ShowID,HideID) {
	  document.getElementById(HideID).style.display = "none"; 
    document.getElementById(ShowID).style.display = "block";
}

