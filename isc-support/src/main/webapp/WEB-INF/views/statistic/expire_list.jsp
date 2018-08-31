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
	<title>APP列表</title>
</head>

<body>
	<form id="queryForm" name="queryForm" action="${ctx}/statistic/expire" method="post">
		<div class="page-container">
			<div class="text-c">
				类型：<select class="select input-text" id="type" name="type" style="width: 120px;">
						<option value="1" <c:if test="${type == 1}">selected="selected"</c:if>>5天后</option>
						<option value="2" <c:if test="${type == 2}">selected="selected"</c:if>>3天后</option>
						<option value="3" <c:if test="${type == 3}">selected="selected"</c:if>>1天后</option>
					</select>&nbsp;&nbsp;&nbsp;&nbsp;
				
				<button type="button" class="btn btn-success" onclick="searchData();"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
				<button type="button" class="btn btn-danger" onclick="resetData();"><i class="Hui-iconfont">&#xe665;</i> 重置</button>
			</div>
			
			<table class="table table-border table-bordered table-bg" style="margin-top: 20px;">
				<thead>
					<tr class="text-c">
						<th width="30">序号</th>
						<th width="100">名称</th>
						<th width="70">生效时间</th>
						<th width="75">过期时间</th>
						<th width="100">证书</th>
						<th width="100">备注</th>
						<th width="130">未签名文件</th>
						<th width="130">已签名文件</th>
						<th width="50">创建时间</th>
						<th width="50">更新时间</th>
					</tr> 
				</thead>
				
				<tbody>
					<c:forEach items="${dataList}" var="vo" varStatus="var">
						<tr class="text-c">
							<td>${var.index + 1}</td>
							<td title="${vo.name}">${vo.name}</td>
							<td><fmt:formatDate value='${vo.effectiveDate }' type="date" pattern="yyyy-MM-dd"/></td>
							<td style="color:red; font-weight: bold;"><fmt:formatDate value='${vo.expireDate }' type="date" pattern="yyyy-MM-dd" /></td>
							<td title="${vo.certificate.name}">${vo.certificate.name}</td>
							<td title="${vo.remark}">${vo.remark}</td>
							<td>
								<a style="text-decoration:none" href="${resUrl}${vo.unsignFile}" title="下载">${vo.unsignFileName}</a> 
							</td>
							<td><a style="text-decoration:none" href="${resUrl}${vo.signFile}" title="下 载">${vo.signFileName}</a> </td>
							
							<td><fmt:formatDate value='${vo.createTime }' type="date" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<td><fmt:formatDate value='${vo.updateTime }' type="date" pattern="yyyy-MM-dd HH:mm:ss"/></td>
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
			$("#type").val("");
			document.getElementById("queryForm").submit();
		}
		
		function addOrUpdate(id){
			var url = "${ctx}/app/detail";
			if(id != null){
				url += "?id=" + id
			}
			
			layer_show("APP信息", url, '700', '500');
		}
		
		function recordList(appId){
			var url = "${ctx}/signRecord/list?appId=" + appId
			layer_show("签名记录", url, '800', '500');
		}
		
	</script>
	
</body>
</html>
