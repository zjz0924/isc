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

.num{
	font-size: 20px;
    color: red;
    font-weight: bold;
}
</style>
</head>

<body>
	<div class="page-container">
		<div style="text-align: center">
			<span style="font-weight: bold;">新增用户：</span> 
			<span class="num">${newUser}</span> 
			
			<span style="margin-left:20px;font-weight: bold;">今日活跃：</span>
			<span class="num">${activeUser}</span> 
			
			<span style="margin-left:20px;font-weight: bold;">累计用户：</span>
			<span class="num">${amountUser}</span>
		</div>
	
		<div class="text-c" style="margin-top: 30px;">
			<div id="container" style="min-width:700px;height:400px"></div>
		</div>
	</div>
	
	<!--_footer 作为公共模版分离出去-->
	<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/resources/js/layer/2.4/layer.js"></script>
	<script type="text/javascript" src="${ctx}/resources/js/H-ui.min.js"></script>
	<script type="text/javascript" src="${ctx}/resources/js/H-ui.admin.js"></script>
	<!--/_footer 作为公共模版分离出去-->
	
	<script type="text/javascript" src="${ctx}/resources/js/My97DatePicker/4.8/WdatePicker.js"></script> 
	<script type="text/javascript" src="${ctx}/resources/js/Highcharts/5.0.6/js/highcharts.js"></script>
	<script type="text/javascript" src="${ctx}/resources/js/Highcharts/5.0.6/js/modules/exporting.js"></script>
	<script type="text/javascript">
		$(function(){
			 document.onkeydown = function (event) {
		        var e = event || window.event;
		        if (e && e.keyCode == 13) { //回车键的键值为13
		        	searchData();
		        }
		     }; 
		     
		     $('#container').highcharts({
		    	title: {
		             text: '${monthTitle} 每天统计详情'
		        },
		    	chart: {
		 			type: 'column'
		 		},
		 		xAxis: {
		 			categories: ${date} 
		 		},
		        yAxis: {
		            title: {
		                text: '新增用户（个）'
		            }
		        },
		 		plotOptions: {
		 			series: {
		 				allowPointSelect: true
		 			}
		 		},
		 		series: [{
		 			name: "新增用户",
		 			data: ${val}
		 		}]
		     });
		     
		});
	
		function searchData(){
			document.getElementById("queryForm").submit();
		} 
		
	</script>
	
</body>
</html>
