function SaltCmd(){
    var tgt = $("#tgt").attr("value"); // 执行主机
    var fun = $("#fun").val(); // 下拉列表，执行模块
    var expr_form = $("#expr_form").val(); // 匹配规则
    var timeout = $("#timeout").attr("value"); // 执行超时时间
    var arg = $("#arg").attr("value");  // input，执行命令
    //var data = "fun=" + fun + "&arg=" + arg + "&tgt=" + tgt;
    var data = { "fun": fun, "arg": arg, "tgt": tgt, 'expr_form':expr_form, 'timeout':timeout };
    var ingData = "<tr><td>1</td><td>" + tgt + "</td><td><img src='/static/images/loading1.gif' /></td><td><font color='green'><b>Running</b></td></tr>";
    $("#CmdRtList").html(ingData);
    $.ajax({ 
        type: "POST",   
        url: "/salt/cmd", 
        data: data,
        dataType: "html",
	success: function(msg){ 
   	    $("#CmdRtList").html(msg); 
	    }, 
	error:function(){ 
  	    alert("提示：执行错误！"); 
	    } 
	}); 
       };

function GetStatus(){
    //$("#host_status").html("正在刷新");
    $("font[name='host_status']").html("正在刷新");
    $.ajax({
       type: "POST",
       url: "/salt/status",
       data: {'fun': 'refresh'},
       dataType: "html",
       success: function(msg){
           $("#status_list").html(msg);
           },
       error:function(){
           alert("提示：加载失败！");
           }
       });
};

$("html").die().live("keydown",function(event){
    if(event.keyCode==13){       
        //调用方法;   
        $("#running_key").click();
        }        
    });
