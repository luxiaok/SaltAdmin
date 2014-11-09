function lossPass() {
	alert("这也能忘记？找系统管理员吧！");
}

function getCookie(name){
    var strCookie=document.cookie;
    var arrCookie=strCookie.split("; ");
    for(var i=0;i<arrCookie.length;i++){
        var arr=arrCookie[i].split("=");
        if(arr[0]==name) return arr[1];
    }
    return 'null';
}

//alert(getCookie('Token'));
//alert(getCookie('Username'));

function deleteCookie(name){ 
    var date=new Date(); 
    date.setTime(date.getTime()-10000);
    document.cookie=name+"=88888; expire="+date.toGMTString();
}

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
	
        //var F = document.LoginForm
        var F = document.getElementById(formId)
        var username = F.username
        var password = F.password
        var keeplogin = document.forms['LoginForm'].rememberMe
        if(username.value=='')
           {
               alert('请输入用户名！');
               username.focus();
               return false;
           }
        if(password.value=='')
           {
               alert('请输入密码！');
               password.focus();
               return false;
           }
        if (keeplogin.checked == true)
	           var kpl = 'yes'
        else
             var kpl = 'no'

	var LF = document.getElementById(formId);
	var url = LF.action;
	//var inputs = LF.elements;
	var postData = "username="+username.value+"&password="+password.value+"&kpl="+kpl;
	xmlHttp.open("POST", url, true);
	xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); 
	xmlHttp.send(postData);
	xmlHttp.onreadystatechange = function() {
		if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
			//tip.innerHTML = xmlHttp.responseText;
			var PostAnswer=xmlHttp.responseText;
                        if(PostAnswer=="true") {  //跳转到管理中心页面
                            referer = getCookie('HTTP_REFERER');
                            if (referer == 'null') {
                                   var referer = "/dashboard";
                                }
                            else { 
                                var referer = unescape(referer);
                                }
                            deleteCookie('HTTP_REFERER');
                            //window.location.href=referer;
                            // 暂时取消 跳转到登录前的页面  的功能
                            window.location.href="/dashboard";
                            //history.go(-1);
                            }
                        else if (PostAnswer=="error") {
                            alert("用户名或密码错误！");
                            document.LoginForm.reset();
                            document.getElementById('username').focus();
                            }
                        else if (PostAnswer=="disable") {
                            alert("该用户已被禁用！");
                            document.LoginForm.reset();
                            document.getElementById('username').focus();
                            }
                        else {
                            alert("服务器错误！");
                            //document.LoginForm.reset();
                            document.getElementById('username').focus();
                            }
		    }
	        }
};

function KeyDown()  
{
  if(event.keyCode == 13) 
    {   
      event.returnValue = false;  
      event.cancel = true;  
      LoginForm.submit.click();  
    }
};

$("html").die().live("keydown",function(event){
    if(event.keyCode==13){
        //调用方法;   
        $("#login_submit").click();
        }; 
    });

