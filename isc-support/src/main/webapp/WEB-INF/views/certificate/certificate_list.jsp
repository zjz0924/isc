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
	<form id="queryForm" name="queryForm" action="${ctx}/certificate/list" method="post">
		<div class="page-container">
		
			<div class="text-c" style="text-align: left;"> 
			            证书过期时间：
				<input type="text" onfocus="WdatePicker({ maxDate:'#F{$dp.$D(\'endCertExpireDate\')||\'%y-%M-%d\'}' })" id="startCertExpireDate" name="startCertExpireDate" class="input-text Wdate" style="width:120px;" value="${startCertExpireDate}">
				-
				<input type="text" onfocus="WdatePicker({ minDate:'#F{$dp.$D(\'startCertExpireDate\')}',maxDate:'%y-%M-%d' })" id="endCertExpireDate" name="endCertExpireDate" class="input-text Wdate" style="width:120px;" value="${endCertExpireDate}">&nbsp;&nbsp;&nbsp;&nbsp;
				
				 描述文件过期时间：
				<input type="text" onfocus="WdatePicker({ maxDate:'#F{$dp.$D(\'endDescExpireDate\')||\'%y-%M-%d\'}' })" id="startDescExpireDate" name="startDescExpireDate" class="input-text Wdate" style="width:120px;" value="${startDescExpireDate}">
				-
				<input type="text" onfocus="WdatePicker({ minDate:'#F{$dp.$D(\'startDescExpireDate\')}',maxDate:'%y-%M-%d' })" id="endDescExpireDate" name="endDescExpireDate" class="input-text Wdate" style="width:120px;" value="${endDescExpireDate}">&nbsp;&nbsp;&nbsp;&nbsp;
			
				名称：<input type="text" class="input-text" style="width:180px"  id="name" name="name" value="${name}">
			</div>
			
			<div class="text-c" style="text-align: left; margin-top: 10px">
			           创建时间：
				<input type="text" onfocus="WdatePicker({ maxDate:'#F{$dp.$D(\'endCreateTime\')||\'%y-%M-%d\'}' })" id="startCreateTime" name="startCreateTime" class="input-text Wdate" style="width:120px;margin-left: 27px;" value="${startCreateTime}">
				-
				<input type="text" onfocus="WdatePicker({ minDate:'#F{$dp.$D(\'startCreateTime\')}',maxDate:'%y-%M-%d' })" id="endCreateTime" name="endCreateTime" class="input-text Wdate" style="width:120px;" value="${endCreateTime}">&nbsp;&nbsp;&nbsp;&nbsp;
				 
				排序：<select class="select input-text" id="sort" name="sort" style="width: 150px;margin-left: 90px;">
		          	<option value="cert_expire_date" <c:if test="${sort == 'cert_expire_date'}">selected="selected"</c:if>>证书过期时间</option>
		          	<option value="desc_expire_date" <c:if test="${sort == 'desc_expire_date'}">selected="selected"</c:if>>描述文件过期时间</option>
					<option value="create_time" <c:if test="${sort == 'create_time'}">selected="selected"</c:if>>创建时间</option>
				</select>
				
				<select class="select input-text" id="order" name="order" style="width: 100px;">
					<option value="asc" <c:if test="${order == 'asc'}">selected="selected"</c:if>>升序</option>
		          	<option value="desc" <c:if test="${order == 'desc'}">selected="selected"</c:if>>降序</option>
				</select>&nbsp;&nbsp;&nbsp;&nbsp; 
				 
				<button type="button" class="btn btn-success" onclick="searchData();"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
				<button type="button" class="btn btn-danger" onclick="resetData();"><i class="Hui-iconfont">&#xe665;</i> 重置</button>
			</div>
			
			<div class="cl pd-5 bg-1 bk-gray mt-20"> 
				<span class="l" style="float: right !important;margin-right: 10px;">
					<a href="javascript:void(0);" onclick="addOrUpdate()" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 添加证书</a>
				</span> 
			</div>
			
			<table class="table table-border table-bordered table-bg">
				<thead>
					<tr class="text-c">
						<th width="40">序号</th>
						<th width="100">证书名</th>
						<th width="80">证书过期时间</th>
						<th width="100">描述文件过期时间</th>
						<th width="130">p12证书</th>
						<th width="130">描述文件</th>
						<th width="120">备注</th>
						<th width="60">创建时间</th>
						<th width="50">操作</th>
					</tr> 
				</thead>
				
				<tbody>
					<c:forEach items="${dataList}" var="vo" varStatus="var">
						<tr class="text-c">
							<td>${var.index + 1}</td>
							<td title="${vo.name}">${vo.name}</td>
							<td style="color:red; font-weight: bold;"><fmt:formatDate value='${vo.certExpireDate }' type="date" pattern="yyyy-MM-dd"/></td>
							<td style="color:red; font-weight: bold;"><fmt:formatDate value='${vo.descExpireDate }' type="date" pattern="yyyy-MM-dd"/></td>
							<td>
								<a style="text-decoration:none" href="${resUrl}${vo.certFile}" title="下载">${vo.certFileName}</a> 
							</td>
							<td><a style="text-decoration:none" href="${resUrl}${vo.descFile}" title="下 载">${vo.descFileName}</a> </td>
							<td title="${vo.remark}">${vo.remark}</td>
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
			$("#name").val("");
			$("#startCertExpireDate").val("");
			$("#endCertExpireDate").val("");
			$("#startDescExpireDate").val("");
			$("#endDescExpireDate").val("");
			$("#startCreateTime").val("");
			$("#endCreateTime").val("");
			document.getElementById("queryForm").submit();
		}
		
		function addOrUpdate(id){
			/*
				参数解释：
				title	标题
				url		请求的url
				id		需要操作的数据id
				w		弹出层宽度（缺省调默认值）
				h		弹出层高度（缺省调默认值）
			*/
			var url = "${ctx}/certificate/detail";
			if(id != null){
				url += "?id=" + id
			}
			
			layer_show("添加证书", url, '700', '500');
		}
		
		
		function deleteCert(id){
			layer.confirm("此操作将删除该证书，您确定要继续吗？", function(index){
				 $.ajax({
                 	url: "${ctx}/certificate/delete",
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
