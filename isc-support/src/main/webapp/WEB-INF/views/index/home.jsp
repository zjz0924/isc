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
	<nav class="breadcrumb"><a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
	<div class="page-container">
		<div>
			<table class="table table-border table-bordered table-bg">
				<thead>
					<tr>
						<th colspan="7" scope="col">数量统计</th>
					</tr>
					<tr class="text-c">
						<th>统计</th>
						<th>新增/个</th>
						<th>新增金额/元</th>
						<th>续费/个</th>
						<th>续费金额/元</th>
						<th>补签/个</th>
						<th>总金额/元</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${numDataList}" var="vo">
						<tr class="text-c">
							<td>${vo.name}</td>
							<td>${vo.add}</td>
							<td>${vo.addSum}</td>
							<td>${vo.renew}</td>
							<td>${vo.renewSum}</td>
							<td>${vo.sumplement}</td>
							<td style="color:red;font-weight:bold;">${vo.addSum + vo.renewSum}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
		<div style="margin-top: 30px;">
			<table class="table table-border table-bordered table-bg" style="width: 50%;">
				<thead>
					<tr>
						<th colspan="7" scope="col">证书统计</th>
					</tr>
					<tr class="text-c">
						<th>证书名</th>
						<th>总数量/个</th>
						<th>今天数量/个</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${certDataList}" var="vo">
						<tr class="text-c">
							<td>${vo.name}</td>
							<td>${vo.add}</td>
							<td style="color:red;font-weight:bold;">${vo.renew}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
	</div>
	
	<!--_footer 作为公共模版分离出去-->
	<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/resources/js/layer/2.4/layer.js"></script>
	<script type="text/javascript" src="${ctx}/resources/js/H-ui.min.js"></script>
	<script type="text/javascript" src="${ctx}/resources/js/H-ui.admin.js"></script>
	<!--/_footer 作为公共模版分离出去-->
	
	<script type="text/javascript" src="${ctx}/resources/js/My97DatePicker/4.8/WdatePicker.js"></script> 
	<script type="text/javascript" src="${ctx}/resources/js/laypage/1.2/laypage.js"></script>
	
</body>
</html>
