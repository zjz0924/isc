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
				<dl class="permission-list">
					<dt>
						<label>APP信息</label>
					</dt>
					<dd>
						<div class="row cl">
							<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>名称：</label>
							<div class="formControls col-xs-8 col-sm-9">
								<input type="text" class="input-text" value="${facadeBean.name}" id="appName" name="appName">
							</div>
						</div>
						
						<div class="row cl">
							<label class="form-label col-xs-4 col-sm-3">备注：</label>
							<div class="formControls col-xs-8 col-sm-9">
								<input type="text" class="input-text" value="${facadeBean.remark}" id="appRemark" name="appRemark">
							</div>
						</div>
						
						<div class="row cl">
							<label class="form-label col-xs-4 col-sm-3">未签名文件：</label>
							<div class="formControls col-xs-8 col-sm-9">
								<c:if test="${not empty facadeBean.id and not empty facadeBean.unsignFile}">
									<p style="color: red;"><a href="${resUrl}${facadeBean.unsignFile}">${facadeBean.unsignFileName}</a></p>
								</c:if>
								<input type="file" class="input-text" id="unsignFile" name="unsignFile">
							</div>
						</div>
						
						<div class="row cl">
							<label class="form-label col-xs-4 col-sm-3">已签名文件：</label>
							<div class="formControls col-xs-8 col-sm-9">
								<c:if test="${not empty facadeBean.id and not empty facadeBean.signFile}">
									<p style="color: red;"><a href="${resUrl}${facadeBean.signFile}">${facadeBean.signFileName}</a></p>
								</c:if>
								<input type="file" class="input-text" id="signFile" name="signFile">
							</div>
						</div>
					</dd>
				</dl>
			</div>
			
			<c:if test="${ empty facadeBean.id }">
				<div class="row cl">
					<dl class="permission-list">
						<dt>
							<label>签名信息</label>
						</dt>
						<dd>
							<div class="row cl">
								<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>套餐：</label>
								<div class="formControls col-xs-8 col-sm-9">
									<select class="select input-text" id="comboId" name="comboId">
										<option value="">请选择</option>
										<c:forEach items="${comboList}" var="vo">
											<option value="${vo.id}">${vo.name} -- ${vo.price}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							
							<div class="row cl">
								<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>证书：</label>
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
								<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>支付方式：</label>
								<div class="formControls col-xs-8 col-sm-9">
									<select class="select input-text" id="payType" name="payType" style="width: 150px;">
										<option value="支付宝" <c:if test="${vo.payType == '支付宝' }">selected="selected"</c:if>>支付宝</option>
										<option value="微信" <c:if test="${vo.payType == '微信' }">selected="selected"</c:if>>微信</option>
										<option value="银行卡" <c:if test="${vo.payType == '银行卡' }">selected="selected"</c:if>>银行卡</option>
									</select>
								</div>
							</div>
						</dd>
					</dl>
				</div>
			</c:if>
			
			<div class="row cl">
				<dl class="permission-list">
					<dt>
						<label>客户信息</label>
					</dt>
					<dd>
						<div class="row cl">
							<label class="form-label col-xs-4 col-sm-3">姓名：</label>
							<div class="formControls col-xs-8 col-sm-9">
								<input type="text" class="input-text" value="${facadeBean.contacts.name}" id="contactsName" name="contactsName" <c:if test="${not empty facadeBean.id}">disabled</c:if>>
							</div>
						</div>
						
						<div class="row cl">
							<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>微信号：</label>
							<div class="formControls col-xs-8 col-sm-9">
								<input type="text" class="input-text" value="${facadeBean.contacts.wechat}" id="wechat" name="wechat" <c:if test="${not empty facadeBean.id}">disabled</c:if>>
							</div>
						</div>
						
						<div class="row cl">
							<label class="form-label col-xs-4 col-sm-3">支付宝：</label>
							<div class="formControls col-xs-8 col-sm-9">
								<input type="text" class="input-text" value="${facadeBean.contacts.alipay}" id="alipay" name="alipay" <c:if test="${not empty facadeBean.id}">disabled</c:if>>
							</div>
						</div>
						
						<div class="row cl">
							<label class="form-label col-xs-4 col-sm-3">电话：</label>
							<div class="formControls col-xs-8 col-sm-9">
								<input type="text" class="input-text" value="${facadeBean.contacts.phone}" id="phone" name="phone" <c:if test="${not empty facadeBean.id}">disabled</c:if>>
							</div>
						</div>
						
						<div class="row cl">
							<label class="form-label col-xs-4 col-sm-3">备注：</label>
							<div class="formControls col-xs-8 col-sm-9">
								<input type="text" class="input-text" value="${facadeBean.contacts.remark}" id="contactsRemark" name="contactsRemark" <c:if test="${not empty facadeBean.id}">disabled</c:if>>
							</div>
						</div>
					</dd>
				</dl>
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
					appName:{
						required:true
					},
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
						url: "${ctx}/app/save?time=" + new Date() ,
						beforeSubmit: function(){
							var appId = "${facadeBean.id}"; 
							
							if(appId == null || appId == "" || appId == undefined){
								var comboId = $("#comboId").val();
								if(comboId  == null || comboId == "" || comboId == undefined){
									layer.msg("请选择套餐", {icon:5, time:1000});
									return false;
								}
								
								var certId = $("#certId").val();
								if(certId  == null || certId == "" || certId == undefined){
									layer.msg("请选择证书", {icon:5, time:1000});
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
