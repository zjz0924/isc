<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

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
	<div class="page-container">
		<table class="table table-border table-bordered table-bg">
			<thead>
				<tr class="text-c">
					<th width="30">序号</th>
					<th width="40">类型</th>
					<th width="70">生效时间</th>
					<th width="70">过期时间</th>
					<th width="120">套餐</th>
					<th width="120">证书</th>
					<th width="60">金额/元</th>
					<th width="60">创建时间</th>
				</tr> 
			</thead>
			
			<tbody>
				<c:forEach items="${dataList}" var="vo" varStatus="var">
					<tr class="text-c">
						<td>${var.index + 1}</td>
						<td><c:if test="${vo.type == 1}">新增</c:if><c:if test="${vo.type == 2}">续费</c:if><c:if test="${vo.type == 3}">补签</c:if></td>
						<td><fmt:formatDate value='${vo.effectiveDate }' type="date" pattern="yyyy-MM-dd"/></td>
						<td style="color:red; font-weight: bold;"><fmt:formatDate value='${vo.expireDate }' type="date" pattern="yyyy-MM-dd" /></td>
						<td title="${vo.combo.name}">${vo.combo.name}</td>
						<td title="${vo.certificate.name}">${vo.certificate.name}</td>
						<td title="${vo.price}">${vo.price}</td>
						<td><fmt:formatDate value='${vo.createTime }' type="date" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
</body>
</html>
