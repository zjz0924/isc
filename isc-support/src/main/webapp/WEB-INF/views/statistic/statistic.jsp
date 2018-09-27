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

	<style type="text/css">
.metro-nav-block {
	display: block;
	float: left;
	height: 70px;
	width: 100px;
	text-decoration: none;
	color: white;
	overflow: hidden;
	position: relative;
	font-weight: 300;
	letter-spacing: 0.02em;
	line-height: 20px;
	font-smooth: always;
	margin: 0 1% 1% 0;
	overflow: hidden;
	z-index: 1;
}

.nav-block-yellow {
	background: #ffb400;
}

.nav-block-green {
    background: #74b749;
}

.nav-block-blue {
    background: #0daed3;
}

.brand {
	position: absolute;
	left: 30px;
	min-height: 30px;
	background-color: transparent;
	font-size: 14px;
}
</style>
</head>

<body>
	<form id="queryForm" name="queryForm" action="${ctx}/statistic/statistic" method="post">
		<div class="page-container">
			<div class="text-c">
				   时间：
				<input type="text" onfocus="WdatePicker()" id="startCreateTime" name="startCreateTime" class="input-text Wdate" style="width:120px;" value="${startCreateTime}">
				-
				<input type="text" onfocus="WdatePicker()" id="endCreateTime" name="endCreateTime" class="input-text Wdate" style="width:120px;" value="${endCreateTime}">&nbsp;&nbsp;&nbsp;&nbsp;
				
				<button type="button" class="btn btn-success" onclick="searchData();"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
				<button type="button" class="btn btn-danger" onclick="resetData();"><i class="Hui-iconfont">&#xe665;</i> 重置</button>
			</div>
			
			<div class="text-c" style="margin-top: 30px;">
				<table class="table table-border table-bordered table-bg">
					<thead>
						<tr>
							<th colspan="7" scope="col">数量统计</th>
						</tr>
						<tr class="text-c">
							<th>新增/个</th>
							<th>新增金额/元</th>
							<th>续费/个</th>
							<th>续费金额/元</th>
							<th>补签/个</th>
							<th>总金额/元</th>
						</tr>
					</thead>
					<tbody>
						<tr class="text-c">
							<td>${numData.add}</td>
							<td>${numData.addSum}</td>
							<td>${numData.renew}</td>
							<td>${numData.renewSum}</td>
							<td>${numData.sumplement}</td>
							<td style="color:red;font-weight:bold;">${numData.addSum + numData.renewSum}</td>
						</tr>
					</tbody>
				</table>
			</div>
			
			<div class="text-c" style="margin-top: 30px;">
				<table class="table table-border table-bordered table-bg">
					<thead>
						<tr>
							<th colspan="7" scope="col">收支统计</th>
						</tr>
						<tr class="text-c">
							<th>收入/元</th>
							<th>支出/元</th>
							<th>净收入/元</th>
						</tr>
					</thead>
					<tbody>
						<tr class="text-c">
							<td>${payData.addSum}</td>
							<td>${payData.renewSum}</td>
							<td style="color:red;font-weight:bold;"><fmt:formatNumber type="number" value="${payData.addSum - payData.renewSum}" pattern="0.0" maxFractionDigits="1"/></td>
						</tr>
					</tbody>
				</table>
			</div>
			
			<div class="text-c" style="margin-top: 30px;">
				<table class="table table-border table-bordered table-bg">
					<thead>
						<tr>
							<th colspan="7" scope="col">支出详情统计</th>
						</tr>
						<tr class="text-c">
							<th>支出类型</th>
							<th>支出金额/元</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${payDetailData}" var="vo">
							<tr class="text-c">
								<td>${vo.name}</td>
								<td>${vo.addSum}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
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
			$("#startCreateTime").val("");
			$("#endCreateTime").val("");
			document.getElementById("queryForm").submit();
		}
		
	</script>
	
</body>
</html>
