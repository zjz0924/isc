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
			<input type="hidden" id="id" name="id" value="${facadeBean.id}"/>
			
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3">姓名：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input type="text" class="input-text" value="${facadeBean.name}" id="name" name="name">
				</div>
			</div>
			
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>微信：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input type="text" class="input-text" value="${facadeBean.wechat}" id="wechat" name="wechat">
				</div>
			</div>
			
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3">支付宝：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input type="text" class="input-text" value="${facadeBean.alipay}" id="alipay" name="alipay">
				</div>
			</div>
			
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3">电话：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input type="text" class="input-text" value="${facadeBean.phone}" id="phone" name="phone">
				</div>
			</div>
			
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3">备注：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<textarea id="remark" name="remark" cols="" rows="2" class="textarea" style="height: 70px;">${facadeBean.remark }</textarea>
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
				rules:{
					wechat:{
						required:true
					}
				},
				onkeyup:false,
				focusCleanup:true,
				success:"valid",
				submitHandler: function(form){
					$(form).ajaxSubmit({
						type: 'post',
						dataType : 'json',
						url: "${ctx}/contacts/save?time=" + new Date() ,
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
