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
	<form id="queryForm" name="queryForm" action="${ctx}/app/list" method="post">
		<div class="page-container">
			<div class="text-c" style="text-align: left;"> 
			          名称：<input type="text" class="input-text" style="width:200px;margin-left:32px;" id="name" name="name" value="${name}">&nbsp;&nbsp;&nbsp;&nbsp;
			          
			            生效时间：
				<input type="text" onfocus="WdatePicker()" id="startEffectiveDate" name="startEffectiveDate" class="input-text Wdate" style="width:120px;" value="${startEffectiveDate}">
				-
				<input type="text" onfocus="WdatePicker()" id="endEffectiveDate" name="endEffectiveDate" class="input-text Wdate" style="width:120px;" value="${endEffectiveDate}">&nbsp;&nbsp;&nbsp;&nbsp;
				
				过期时间：
				<input type="text" onfocus="WdatePicker()" id="startExpireDate" name="startExpireDate" class="input-text Wdate" style="width:120px;" value="${startExpireDate}">
				-
				<input type="text" onfocus="WdatePicker()" id="endExpireDate" name="endExpireDate" class="input-text Wdate" style="width:120px;" value="${endExpireDate}">
			</div>
			
			<div class="text-c" style="text-align: left; margin-top: 10px">
				证书：<select class="select input-text" id="certId" name="certId" style="width: 200px;margin-left:32px;">
						<option value="">全部</option>
						<c:forEach items="${certificateList}" var="vo">
							<option value="${vo.id}" <c:if test="${vo.id == certId}">selected="selected"</c:if>>${vo.name}</option>
						</c:forEach>
					</select>&nbsp;&nbsp;&nbsp;&nbsp;
			
				 创建时间：
				<input type="text" onfocus="WdatePicker()" id="startCreateTime" name="startCreateTime" class="input-text Wdate" style="width:120px;" value="${startCreateTime}">
				-
				<input type="text" onfocus="WdatePicker()" id="endCreateTime" name="endCreateTime" class="input-text Wdate" style="width:120px;" value="${endCreateTime}">&nbsp;&nbsp;&nbsp;&nbsp;
				
				 更新时间：
				<input type="text" onfocus="WdatePicker()" id="startUpdateTime" name="startUpdateTime" class="input-text Wdate" style="width:120px;" value="${startUpdateTime}">
				-
				<input type="text" onfocus="WdatePicker()" id="endUpdateTime" name="endUpdateTime" class="input-text Wdate" style="width:120px;" value="${endUpdateTime}">
			</div>
			
			<div class="text-c" style="text-align: left; margin-top: 10px">
				微信：<input type="text" class="input-text" style="width:200px;margin-left:32px;" id="wechat" name="wechat" value="${wechat}">&nbsp;&nbsp;&nbsp;&nbsp;
				
				排序：<select class="select input-text" id="sort" name="sort" style="width: 120px;margin-left: 31px;">
			          	<option value="update_time" <c:if test="${sort == 'update_time'}">selected="selected"</c:if>>更新时间</option>
			          	<option value="create_time" <c:if test="${sort == 'create_time'}">selected="selected"</c:if>>创建时间</option>
						<option value="effective_date" <c:if test="${sort == 'effective_date'}">selected="selected"</c:if>>生效日期</option>
						<option value="expire_date" <c:if test="${sort == 'expire_date'}">selected="selected"</c:if>>过期日期</option>
					</select>&nbsp;&nbsp;&nbsp;
					
					<select class="select input-text" id="order" name="order" style="width: 120px;">
			          	<option value="desc" <c:if test="${order == 'desc'}">selected="selected"</c:if>>降序</option>
			          	<option value="asc" <c:if test="${order == 'asc'}">selected="selected"</c:if>>升序</option>
					</select>&nbsp;&nbsp;&nbsp;&nbsp;
					
				是否新增：
				<select class="select input-text" id="isNew" name="isNew" style="width: 252px;">
			          	<option value="">全部</option>
			          	<option value="0" <c:if test="${isNew == 0}">selected="selected"</c:if>>否</option>
						<option value="1" <c:if test="${isNew == 1}">selected="selected"</c:if>>是</option>
				</select>&nbsp;&nbsp;&nbsp;
			</div>
			
			<div class="text-c" style="text-align: left; margin-top: 10px">
				是否使用：
				<select class="select input-text" id="valid" name="valid" style="width: 200px;">
					<option value="">全部</option>
					<option value="1" <c:if test="${valid == 1}">selected="selected"</c:if>>是</option>
					<option value="0" <c:if test="${valid == 0}">selected="selected"</c:if>>否</option>
				</select>&nbsp;&nbsp;&nbsp;&nbsp;
				
				是否有效：
				<select class="select input-text" id="isEffective" name="isEffective" style="width: 252px;">
			          	<option value="">全部</option>
			          	<option value="0" <c:if test="${isEffective == 0}">selected="selected"</c:if>>否</option>
						<option value="1" <c:if test="${isEffective == 1}">selected="selected"</c:if>>是</option>
				</select>&nbsp;&nbsp;&nbsp;
				
				<button type="button" class="btn btn-success" onclick="searchData();"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
				<button type="button" class="btn btn-danger" onclick="resetData();"><i class="Hui-iconfont">&#xe665;</i> 重置</button>	
			</div>
			
			<div class="cl pd-5 bg-1 bk-gray mt-20"> 
				<span class="l" style="float: right !important;margin-right: 10px;">
					<a href="javascript:void(0);" onclick="addOrUpdate()" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 添加APP</a>&nbsp;&nbsp;<a href="${ctx}/app/exportApp" class="btn btn-success radius"><i class="Hui-iconfont">&#xe641;</i> 导出</a>
				</span> 
			</div>
			
			<table class="table table-border table-bordered table-bg">
				<thead>
					<tr class="text-c">
						<th width="30">序号</th>
						<th width="70">名称</th>
						<th width="70">生效时间</th>
						<th width="75">过期时间</th>
						<th width="80">证书</th>
						<th width="80">客户微信</th>
						<th width="125">ipa包</th>
						<th width="28">使用</th>
						<th width="28">有效</th>
						<th width="30">创建时间</th>
						<th width="30">更新时间</th>
						<th width="60">备注</th>
						<th width="70">操作</th>
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
							<td title="${vo.contacts.wechat }">${vo.contacts.wechat }</td>
							<td>
								<a style="text-decoration:none" href="${resUrl}${vo.unsignFile}" title="下载">${vo.unsignFileName}</a></br>
								<a style="text-decoration:none" href="${resUrl}${vo.signFile}" title="下 载">${vo.signFileName}</a>
							</td>
							<td>
								<c:if test="${vo.valid == 0}"><span style="color:red; font-weight: bold;">否</span></c:if>
								<c:if test="${vo.valid == 1}"><span style="color:green; font-weight: bold;">是</span></c:if>
							</td>
							<td>
								<c:if test="${vo.isEffective == 0}"><span style="color:red; font-weight: bold;">否</span></c:if>
								<c:if test="${vo.isEffective == 1}"><span style="color:green; font-weight: bold;">是</span></c:if>
							</td>
							<td><fmt:formatDate value='${vo.createTime }' type="date" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<td><fmt:formatDate value='${vo.updateTime }' type="date" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<td title="${vo.remark}">${vo.remark}</td>
							<td class="td-manage">
								<a title="续费" href="javascript:void(0)" onclick="renew(${vo.id})" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe60c;</i></a>
								<a title="补签" href="javascript:void(0)" onclick="supplement(${vo.id})" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe615;</i></a>
								<a title="签名记录" href="javascript:void(0)" onclick="recordList(${vo.id})" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe616;</i></a>
								<a title="编辑" href="javascript:void(0)" onclick="addOrUpdate(${vo.id})" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>
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
			$("#startEffectiveDate").val("");
			$("#endEffectiveDate").val("");
			$("#startExpireDate").val("");
			$("#endExpireDate").val("");
			$("#startCreateTime").val("");
			$("#endCreateTime").val("");
			$("#startUpdateTime").val("");
			$("#endUpdateTime").val("");
			$("#certId").val("");
			$("#wechat").val("");
			$("#isNew").val("");
			$("#valid").val("");
			$("#isEffective").val("");
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
		
		function renew(appId){
			var url = "${ctx}/app/renewDetail?appId=" + appId
			layer_show("续费", url, '600', '400');
		}
		
		function supplement(appId){
			var url = "${ctx}/app/supplementDetail?appId=" + appId
			layer_show("补签", url, '500', '300');
		}
		
		function deleteCert(id){
			layer.confirm("此操作将删除该APP，您确定要继续吗？", function(index){
				 $.ajax({
                 	url: "${ctx}/app/delete",
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
