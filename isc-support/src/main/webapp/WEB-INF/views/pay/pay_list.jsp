<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>
<%@include file="/page/NavPageBar.jsp" %>

<!DOCTYPE HTML>
<html>
<head>
	<meta charset="utf-8">
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	<link rel="stylesheet" type="text/css" href="${ctx}/resources/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/style.css" />
	<title>证书列表</title>
</head>

<body>
	<form id="queryForm" name="queryForm" action="${ctx}/pay/list" method="post">
		<div class="page-container">
			<div class="text-c"> 
				  支出时间：
				<input type="text" onfocus="WdatePicker()" id="startPayDate" name="startPayDate" class="input-text Wdate" style="width:120px;" value="${startPayDate}">
				-
				<input type="text" onfocus="WdatePicker()" id="endPayDate" name="endPayDate" class="input-text Wdate" style="width:120px;" value="${endPayDate}">&nbsp;&nbsp;&nbsp;&nbsp;
			
			            创建时间：
				<input type="text" onfocus="WdatePicker()" id="startCreateTime" name="startCreateTime" class="input-text Wdate" style="width:120px;" value="${startCreateTime}">
				-
				<input type="text" onfocus="WdatePicker()" id="endCreateTime" name="endCreateTime" class="input-text Wdate" style="width:120px;" value="${endCreateTime}">&nbsp;&nbsp;&nbsp;&nbsp;
				
				<button type="button" class="btn btn-success" onclick="searchData();"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
				<button type="button" class="btn btn-danger" onclick="resetData();"><i class="Hui-iconfont">&#xe665;</i> 重置</button>
			</div>
			
			<div class="cl pd-5 bg-1 bk-gray mt-20"> 
				<span style="margin-left: 10px; display: inline-block;padding-top: 5px;">总金额： <span style="font-weight:bold; color:red;">${total}</span>&nbsp;&nbsp;元</span>
				<span class="l" style="float: right !important;margin-right: 10px;">
					<a href="javascript:void(0);" onclick="addOrUpdate()" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 添加支出</a>&nbsp;&nbsp;<a href="${ctx}/pay/exportList" class="btn btn-success radius"><i class="Hui-iconfont">&#xe641;</i> 导出</a>
				</span> 
			</div>
			
			<table class="table table-border table-bordered table-bg">
				<thead>
					<tr class="text-c">
						<th width="40">序号</th>
						<th width="150">支付时间</th>
						<th width="400">备注</th>
						<th width="100">金额/元</th>
						<th width="60">创建时间</th>
						<th width="40">操作</th>
					</tr> 
				</thead>
				
				<tbody>
					<c:forEach items="${dataList}" var="vo" varStatus="var">
						<tr class="text-c">
							<td>${var.index + 1}</td>
							<td><fmt:formatDate value='${vo.payDate }' type="date" pattern="yyyy-MM-dd"/></td>
							<td title="${vo.remark}">${vo.remark}</td>
							<td title="${vo.price}">${vo.price}</td>
							<td><fmt:formatDate value='${vo.createTime }' type="date" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<td class="td-manage">
								<a title="编辑" href="javascript:void(0)" onclick="addOrUpdate(${vo.id})" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a> &nbsp;
								<a title="删除" href="javascript:void(0)" onclick="deleteCert(${vo.id})" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<pagination:pagebar startRow="${dataList.getStartRow()}" id="queryForm" pageSize="${dataList.getPageSize()}"  totalSize="${dataList.getTotal()}"   showbar="true"  showdetail="true"/>
		</div>
	</form>
	
	<!--_footer 作为公共模版分离出去-->
	<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/resources/js/layer/2.4/layer.js"></script>
	<script type="text/javascript" src="${ctx}/resources/js/H-ui.min.js"></script>
	<script type="text/javascript" src="${ctx}/resources/js/H-ui.admin.js"></script>
	<!--/_footer 作为公共模版分离出去-->
	
	<script type="text/javascript" src="${ctx}/resources/js/My97DatePicker/4.8/WdatePicker.js"></script> 
	<script type="text/javascript" src="${ctx}/resources/js/laypage/1.2/laypage.js"></script>
	<script type="text/javascript">
		$(function(){
			 document.onkeydown = function (event) {
		        var e = event || window.event;
		        if (e && e.keyCode == 13) { //回车键的键值为13
		        	searchData();
		        }
		     }; 
		});
	
		function searchData(){
			document.getElementById("queryForm").submit();
		} 
		
		function resetData(){
			$("#startPayDate").val("");
			$("#endPayDate").val("");
			$("#startCreateTime").val("");
			$("#endCreateTime").val("");
			document.getElementById("queryForm").submit();
		}
		
		function addOrUpdate(id){
			var url = "${ctx}/pay/detail";
			if(id != null){
				url += "?id=" + id
			}
			layer_show("添加支出", url, '500', '300');
		}
		
		
		function deleteCert(id){
			layer.confirm("此操作将删除该支出，您确定要继续吗？", function(index){
				 $.ajax({
                 	url: "${ctx}/pay/delete",
                 	data: {
                 		id: id,
                 	},
                 	success: function(data){
                 		if(data.success){
                 			layer.msg(data.msg, {icon: 6,time:1000}, function(){
                 				window.location.reload();
                 			});
         				}else{
         					layer.msg(data.msg, {icon: 5,time:1000});
         				}
                 	}
                 });
			});
		}
		
	</script>
	
</body>
</html>
