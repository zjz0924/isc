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
		<form class="form form-horizontal" id="form-admin-add" enctype="multipart/form-data">
			<input type="hidden" id="id" name="id" value="${facadeBean.id}"/>
			
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>证书名称：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input type="text" class="input-text" value="${facadeBean.name}" id="name" name="name">
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>证书过期时间：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input type="text" id="certExpireDate" name="certExpireDate" onfocus="WdatePicker()" readonly="readonly" class="input-text Wdate" value="<fmt:formatDate value='${facadeBean.certExpireDate}' type="date" pattern="yyyy-MM-dd"/>">
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>描述文件过期时间：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input type="text" id="descExpireDate" name="descExpireDate" onfocus="WdatePicker()" readonly="readonly" class="input-text Wdate" value="<fmt:formatDate value='${facadeBean.descExpireDate}' type="date" pattern="yyyy-MM-dd"/>">
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>证书：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<c:if test="${not empty facadeBean.id}">
						<p style="color: red;"><a href="${resUrl}${facadeBean.certFile}">${facadeBean.certFileName}</a></p>
					</c:if>
					<input type="file" class="input-text" id="certFile" name="certFile">
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>描述文件：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<c:if test="${not empty facadeBean.id}">
						<p style="color: red;"><a href="${resUrl}${facadeBean.descFile}">${facadeBean.descFileName}</a></p>
					</c:if>
					<input type="file" class="input-text" id="descFile" name="descFile">
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
					name:{
						required:true
					},
					certExpireDate:{
						required:true
					},
					descExpireDate:{
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
						url: "${ctx}/certificate/save?time=" + new Date() ,
						beforeSubmit: function(){
							var certId = "${facadeBean.id}"; 
							
							if(certId == null || certId == "" || certId == undefined){
								if(document.getElementById("certFile").files.length == 0){
									layer.msg("请选择证书", {icon:5, time:1000});
								    $("#certFile").val("");
									return false;
								}
								
								if(document.getElementById("descFile").files.length == 0){
									layer.msg("请选择描述文件", {icon:5, time:1000});
								    $("#descFile").val("");
									return false;
								}
							}
							
							if(document.getElementById("certFile").files.length != 0){
								var certFile = document.getElementById("certFile").files[0].name;
								if(certFile.substring(certFile.lastIndexOf(".") + 1) != "p12"){
									layer.msg("证书格式不正确，请选择正确的证书", {icon:5, time:1000});
								    $("#certFile").val("");
									return false;
								}
							}
							
							if(document.getElementById("descFile").files.length != 0){
								var descFile = document.getElementById("descFile").files[0].name; 
								if(descFile.substring(descFile.lastIndexOf(".") + 1) != "mobileprovision"){
									layer.msg("描述文件格式不正确，请选择正确的描述文件", {icon:5, time:1000});
								    $("#descFile").val("");
									return false;
								}
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
