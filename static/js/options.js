// 是否禁用
function isDisable()
{
    return confirm('确定禁用该条配置？');
}

// 是否启用
function isEnable()
{
    return confirm('确定启用该条配置？');
}

// 是否删除
function isDel()
{
    return confirm('确定删除该条配置？');
}

// 新增
function AddOps() {
	//document.getElementById("AddTr").style.display = "none"; 
    document.getElementById("AddTr").style.display = "table-row";
}

// 取消新增
function CancellNullOps() {
	document.getElementById("AddTr").style.display = "none"; 
    //document.getElementById("AddTr").style.display = "inline";
}

// 重置表单
function ResetForm(FormID) {
	document.getElementById(FormID).reset();
	document.getElementById('AddType').focus();
	
}

// 提交新增
function SubmitOps() {
	//document.getElementById("AddForm").submit();
	document.AddForm.submit();
}

// 编辑模式与取消编辑模式
function EditOps(ShowID,HideID) {
	document.getElementById(HideID).style.display = "none"; 
    document.getElementById(ShowID).style.display = "table-row";
}

// 保存编辑后的结果
function SaveOps(FormID) {
	//document.getElementById("EditOps").style.display = "none"; 
    //document.getElementById("ShowOps").style.display = "inline";
    //document.EdiForm.submit();
    document.getElementById(FormID).submit();
}

