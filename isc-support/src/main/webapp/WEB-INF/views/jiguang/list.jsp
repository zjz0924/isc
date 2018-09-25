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
	<form id="queryForm" name="queryForm" action="${ctx}/syscData/list" method="post">
		<div class="page-container">
			<div class="row cl">
				<div class="formControls col-xs-11 col-sm-12">
					 Token：<textarea type="text" class="input-text" style="width:80%;height: 90px;margin-left: 15px;" id="token" name="token">${token}</textarea>&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button" class="btn btn-success" onclick="syncData();"><i class="Hui-iconfont">&#xe665;</i> 同步</button>
				</div>
			</div>
			
			<div class="cl pd-5 bg-1 bk-gray mt-20"> 
				<span style="margin-left: 10px; display: inline-block;padding-top: 5px;">上次同步时间：<span style="font-weight:bold; color:red;"><fmt:formatDate value='${ lastSyncTime }' type="date" pattern="yyyy-MM-dd HH:mm:ss"/></span></span>
			
				<span class="l" style="float: right !important;margin-right: 10px;">
					名称：<input type="text" class="input-text" style="width:180px" id="name" name="name" value="${name}">&nbsp;&nbsp;&nbsp;&nbsp;
						排序：<select class="select input-text" id="sort" name="sort" style="width: 120px;margin-left: 31px;">
			          	<option value="new" <c:if test="${sort == 'new'}">selected="selected"</c:if>>新增用户</option>
			          	<option value="total" <c:if test="${sort == 'total'}">selected="selected"</c:if>>总用户</option>
					</select>&nbsp;
					<select class="select input-text" id="order" name="order" style="width: 120px;">
			          	<option value="desc" <c:if test="${order == 'desc'}">selected="selected"</c:if>>降序</option>
			          	<option value="asc" <c:if test="${order == 'asc'}">selected="selected"</c:if>>升序</option>
					</select>&nbsp;&nbsp;&nbsp;
					<button type="button" class="btn btn-success" onclick="searchData();"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
					<button type="button" class="btn btn-danger" onclick="resetData();"><i class="Hui-iconfont">&#xe665;</i> 重置</button>
				</span> 
			</div>
			
			<table class="table table-border table-bordered table-bg">
				<thead>
					<tr class="text-c">
						<th width="40">序号</th>
						<th width="120">名称</th>
						<th width="120">今日新增用户</th>
						<th width="120">总用户</th>
						<th width="50">操作</th>
					</tr> 
				</thead>
				
				<tbody>
					<c:forEach items="${dataList}" var="vo" varStatus="var">
						<tr class="text-c">
							<td>${var.index + 1}</td>
							<td title="${vo.name}">${vo.name}</td>
							<td title="${vo.item.amountNewToday}" style="color: red; font-weight: bold;">${vo.item.amountNewToday}</td>
							<td title="${vo.item.userAmount}">${vo.item.userAmount}</td>
							<td class="td-manage">
								<a title="详情" href="javascript:void(0)" onclick="detail('${vo.key}', '${vo.name}')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe665;</i></a> &nbsp;
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
			$("#name").val("");
			document.getElementById("queryForm").submit();
		}
		
		function detail(appKey, name){
			var url = "${ctx}/syscData/detail?appKey=" + appKey;
			
			var index = layer.open({
				type: 2,
				area: ['850px', '500px'],
				fix: false, //不固定
				maxmin: true,
				shade:0.4,
				title: name,
				content: url
			});
			layer.full(index);  // 全屏
		}
		
		function syncData(){
			var token = $("#token").val();
			if(token === null || token === undefined || token === ""){
				layer.msg("请输入Token的值", {icon: 5,time:1000});
				return false;
			}
			
			layer.confirm("是否确认同步最新数据？", function(index){
				 var index = layer.open({ type: 1, title: false //不显示标题栏
					  ,closeBtn: false, area: '300px;'
					  ,shade: 0.8, id: 'LAY_layuipro' //设定一个id，防止重复弹出
					  ,resize: false, moveType: 1 //拖拽模式，0或者1
					  ,content: '<p align="center"><img src="${ctx}/resources/img/timg.gif" style="width: 150px; height: 150px;"/>数据同步中...</p>'
			     }); 
				
				 $.ajax({
                	url: "${ctx}/syscData/sync",
                	data: {
                		token: token,
                	},
                	success: function(data){
                		if(data.success){
                			alert("同步成功");
                			window.location.reload();
        				}else{
        					layer.msg(data.msg, {icon: 5,time:1000}, function(){
        						layer.close(index);
        					});
        				}
                	}
                });
			});
		}
	</script>
	
</body>
</html>
