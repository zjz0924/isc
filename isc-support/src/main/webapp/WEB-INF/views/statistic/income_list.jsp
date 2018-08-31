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
	<title>签名记录</title>
</head>

<body>
	<form id="queryForm" name="queryForm" action="${ctx}/statistic/income" method="post">
		<div class="page-container">
			<div class="text-c"> 
			
				类型：<select class="select input-text" id="type" name="type" style="width: 150px;">
					<option value="">全部</option>
					<option value="1" <c:if test="${1 == type}">selected="selected"</c:if>>新增</option>
					<option value="2" <c:if test="${2 == type}">selected="selected"</c:if>>续费</option>
				</select>&nbsp;&nbsp;
				
				支付方式：<select class="select input-text" id="payType" name="payType" style="width: 150px;">
					<option value="">全部</option>
					<option value="支付宝" <c:if test="${payType == '支付宝' }">selected="selected"</c:if>>支付宝</option>
					<option value="微信" <c:if test="${payType == '微信' }">selected="selected"</c:if>>微信</option>
					<option value="银行卡" <c:if test="${payType == '银行卡' }">selected="selected"</c:if>>银行卡</option>
				</select>&nbsp;&nbsp;
			
			            创建时间：
				<input type="text" onfocus="WdatePicker({})" id="startCreateTime" name="startCreateTime" class="input-text Wdate" style="width:120px;" value="${startCreateTime}">
				-
				<input type="text" onfocus="WdatePicker({})" id="endCreateTime" name="endCreateTime" class="input-text Wdate" style="width:120px;" value="${endCreateTime}">&nbsp;&nbsp;&nbsp;&nbsp;
				
				<button type="button" class="btn btn-success" onclick="searchData();"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
				<button type="button" class="btn btn-danger" onclick="resetData();"><i class="Hui-iconfont">&#xe665;</i> 重置</button>
			</div>
		
			<div class="cl pd-5 bg-1 bk-gray mt-20"> 
				<span class="l" style="float: right !important;margin-right: 10px;">
					<a href="${ctx}/statistic/exportList" class="btn btn-success radius"><i class="Hui-iconfont">&#xe641;</i> 导出</a>
				</span> 
			</div>
		
			<table class="table table-border table-bordered table-bg">
				<thead>
					<tr class="text-c">
						<th width="30">序号</th>
						<th width="100">APP</th>
						<th width="40">类型</th>
						<th width="50">生效时间</th>
						<th width="50">过期时间</th>
						<th width="140">套餐</th>
						<th width="120">证书</th>
						<th width="80">支付方式</th>
						<th width="70">金额/元</th>
						<th width="70">创建时间</th>
					</tr> 
				</thead>
				
				<tbody>
					<c:forEach items="${dataList}" var="vo" varStatus="var">
						<tr class="text-c">
							<td>${var.index + 1}</td>
							<td title="${vo.app.name}">${vo.app.name}</td>
							<td><c:if test="${vo.type == 1}">新增</c:if><c:if test="${vo.type == 2}">续费</c:if></td>
							<td><fmt:formatDate value='${vo.effectiveDate }' type="date" pattern="yyyy-MM-dd"/></td>
							<td><fmt:formatDate value='${vo.expireDate }' type="date" pattern="yyyy-MM-dd" /></td>
							<td title="${vo.combo.name}">${vo.combo.name}</td>
							<td title="${vo.certificate.name}">${vo.certificate.name}</td>
							<td title="${vo.payType}">${vo.payType}</td>
							<td title="${vo.price}">${vo.price}</td>
							<td><fmt:formatDate value='${vo.createTime }' type="date" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<pagination:pagebar startRow="${dataList.getStartRow()}" id="queryForm" pageSize="${dataList.getPageSize()}"  totalSize="${dataList.getTotal()}"   showbar="true"  showdetail="true"/>
		</div>
	</form>
	
	<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/resources/js/My97DatePicker/4.8/WdatePicker.js"></script> 
	
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
			$("#type").val("");
			$("#payType").val("");
			$("#startCreateTime").val("");
			$("#endCreateTime").val("");
			document.getElementById("queryForm").submit();
		}
	</script>
	
</body>
</html>
