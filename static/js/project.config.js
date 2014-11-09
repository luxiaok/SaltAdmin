var i = 3;
function addRow(tableID,sm)
{
    //var newRow = document.all(tableID).insertRow();
    a = "<tr><td class='textLeft'>后端Web机" + i + "</td>";
    b = "<td class='inputRight'><select class='selectmenu' name='bw' ";
    b += "id='bw_" + i + "' >"
    b += "<option value='0' selected='selected'>-- 选择Web机 --</option>";
    b += sm
    b += "</select></td>"
    c = "<td class='textLeft'>Web" + i + "配置文件</td>"
    d = "<td class='inputRight'><input type='text' class='maininput' value='默认为空即可' name='bwconf' /> <a href='javascript:void(0)' onclick='removeRow(this)'>删除</a></td></tr>"
    t = a + b + c + d;
    //得到表的对象并插入一行，下面是插入了行以后，填充相应的列节点，如下面所示
    /*
    tdA = newRow.insertCell();//插入列的节点
    tdA.innerHTML = a;//列里面填充的值，innerHtml值列内的所有元素
    tdA.className = 'textLeft';
    tdB = newRow.insertCell();
    tdB.innerHTML = b;
    tdB.className = 'inputRight';
    tdC = newRow.insertCell();
    tdC.innerHTML = c;
    tdC.className = 'textLeft';
    tdD = newRow.insertCell();
    tdD.innerHTML = d;
    tdD.className = 'inputRight';
    */
    $('#'+tableID).append(t);
    document.getElementById("bw_" + i).focus();
    i += 1;
    }

function removeRow(src)
   {
    var oRow = src.parentElement.parentElement;  //获取当前事件的父节点
    document.all("WebConfig").deleteRow(oRow.rowIndex);  //删除当前列
   }
