<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<!DOCTYPE html>
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
	<title>添加证书</title>
</head>

<body>
	<article class="page-container">
		<form class="form form-horizontal" id="form-admin-add">
			<input type="hidden" id="appId" name="appId" value="${appId}"/>
			
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>套餐：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<select class="select input-text" id="comboId" name="comboId">
						<option value="">请选择</option>
						<c:forEach items="${comboList}" var="vo">
							<option value="${vo.id}">${vo.name}</option>
						</c:forEach>
					</select>
				</div>
			</div>	
			
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>支付方式：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<select class="select input-text" id="payType" name="payType">
						<option value="支付宝" <c:if test="${vo.payType == '支付宝' }">selected="selected"</c:if>>支付宝</option>
						<option value="微信" <c:if test="${vo.payType == '微信' }">selected="selected"</c:if>>微信</option>
						<option value="银行卡" <c:if test="${vo.payType == '银行卡' }">selected="selected"</c:if>>银行卡</option>
					</select>
				</div>
			</div>
			
			<div class="row cl">
				<p style="color:red;margin-left: 20px;">注意：如果证书没有更改，请不要选择证书</p>
				<label class="form-label col-xs-4 col-sm-3">证书：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<select class="select input-text" id="certId" name="certId">
						<option value="">请选择</option>
						<c:forEach items="${certificateList}" var="vo">
							<option value="${vo.id}">${vo.name}</option>
						</c:forEach>
					</select>
				</div>
			</div>	
			
			<div class="row cl">
				<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
					<input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
				</div>
			</div>
		</form>
	</article>
	
	<!--_footer 作为公共模版分离出去--> 
	<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script> 
	<script type="text/javascript" src="${ctx}/resources/js/layer/2.4/layer.js"></script>
	<script type="text/javascript" src="${ctx}/resources/js/H-ui.min.js"></script> 
	<script type="text/javascript" src="${ctx}/resources/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->
	
	<!--请在下方写此页面业务相关的脚本-->
	<script type="text/javascript" src="${ctx}/resources/js/jquery.validation/1.14.0/jquery.validate.js"></script> 
	<script type="text/javascript" src="${ctx}/resources/js/jquery.validation/1.14.0/validate-methods.js"></script> 
	<script type="text/javascript" src="${ctx}/resources/js/jquery.validation/1.14.0/messages_zh.js"></script> 
	<script type="text/javascript" src="${ctx}/resources/js/My97DatePicker/4.8/WdatePicker.js"></script> 
	<script type="text/javascript">
		$(function(){
			$("#form-admin-add").validate({
				onkeyup:false,
				focusCleanup:true,
				success:"valid",
				submitHandler: function(form){
					$(form).ajaxSubmit({
						type: 'post',
						dataType : 'json',
						url: "${ctx}/app/renew?time=" + new Date() ,
						beforeSubmit: function(){
							var comboId = $("#comboId").val();
							if(comboId  == null || comboId == "" || comboId == undefined){
								layer.msg("请选择套餐", {icon:5, time:1000});
								return false;
							}
						},
						success: function(data){
							if(data.success){
								layer.msg(data.msg, {icon:6,time:1000}, function(){
									parent.window.location.reload();
								});
							}else{
								layer.msg(data.msg, {icon:5, time:1000});
							}
						},
		                error: function(XmlHttpRequest, textStatus, errorThrown){
							layer.msg('error!',{icon:5,time:1000});
						}
					});
				}
			});
		});
	</script>
	
</body>
</html>
