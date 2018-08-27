<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>
<%@include file="/page/NavPageBar.jsp"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="${ctx}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${ctx}/resources/css/font-awesome.min.css" rel="stylesheet">
    <link href="${ctx}/resources/css/style.min.css" rel="stylesheet">
    <link href="${ctx}/resources/css/add-ons.min.css" rel="stylesheet">
    <script src="${ctx}/resources/js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.2/artDialog.source.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.2/jquery.artDialog.source.js?skin=idialog"></script>
    <script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.2/plugins/iframeTools.source.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/tools.js"></script>

    <script type="text/javascript">
        $(function(){
            var resultCode = "${resultCode}";
            if(resultCode != null && resultCode != '' && resultCode != undefined){
                var resultMsg = "${resultMsg}";
                // 设置按钮不可点
                $("#saveBtn").attr("class", "btn btn-primary disabled");

                if(resultCode == "01" || resultCode == "03"){ 
                    window.location.href = "${ctx}/signRecordController/list";
                }else{
                    // 设置按钮可点
                    $("#saveBtn").attr("class", "btn btn-primary");
                }
            }

            var mode = "${mode}";
            if(mode == "readonly"){
                $(":input").attr("disabled","true");
            }

            //自适应高度
            window.parent.adapter(document.body.scrollHeight + 10);
        });

        function checkData(){


        }
    </script>
</head>

<body>
    <div class="row">
        <div class="col-lg-12">
            <ol class="breadcrumb">
                <li><i class="fa fa-home"></i><a href="index.html">首页</a></li>
                <li><i class="fa fa-user"></i><a href="${ctx}/signRecordController/list">^管理</a></li>
                <li><i class="fa fa-user"></i>^信息</li>
            </ol>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h2><i class="fa fa-user red"></i><span class="break"></span><strong>^信息</strong></h2>

                </div>

                <div class="panel-body" style="padding-top:30px;padding-left:30px;">
                    <form action="${ctx}/signRecordController/save" method="post" onsubmit="return checkData();">
                        <input type="hidden" id="id" name="id" value="${facadeBean.id}"/>
                        <div class="form-group height_30">
                            <label class="col-md-2 control-label">type</label>
                            <div class="col-md-3">
                                <input type="text" id="type" name="type" class="form-control" value="${facadeBean.type}">
                            </div>
                        </div>

                        <div class="form-group height_30">
                            <label class="col-md-2 control-label">packageId</label>
                            <div class="col-md-3">
                                <input type="text" id="packageId" name="packageId" class="form-control" value="${facadeBean.packageId}">
                            </div>
                        </div>

                        <div class="form-group height_30">
                            <label class="col-md-2 control-label">price</label>
                            <div class="col-md-3">
                                <input type="text" id="price" name="price" class="form-control" value="${facadeBean.price}">
                            </div>
                        </div>

                        <div class="form-group height_30">
                            <label class="col-md-2 control-label">effectiveDate</label>
                            <div class="col-md-3">
                                <p class="form-control-static">
                                    <fmt:formatDate value='${facadeBean.effectiveDate}' type="date" pattern="yyyy-MM-dd hh:mm:ss" />
                                </p>
                            </div>
                        </div>

                        <div class="form-group height_30">
                            <label class="col-md-2 control-label">expireDate</label>
                            <div class="col-md-3">
                                <p class="form-control-static">
                                    <fmt:formatDate value='${facadeBean.expireDate}' type="date" pattern="yyyy-MM-dd hh:mm:ss" />
                                </p>
                            </div>
                        </div>

                        <div class="form-group height_30">
                            <label class="col-md-2 control-label">appId</label>
                            <div class="col-md-3">
                                <input type="text" id="appId" name="appId" class="form-control" value="${facadeBean.appId}">
                            </div>
                        </div>

                        <div class="form-group height_30">
                            <label class="col-md-2 control-label">createTime</label>
                            <div class="col-md-3">
                                <p class="form-control-static">
                                    <fmt:formatDate value='${facadeBean.createTime}' type="date" pattern="yyyy-MM-dd hh:mm:ss" />
                                </p>
                            </div>
                        </div>

                        <c:if test="${mode != 'readonly'}">
                            <div class="form-group height_30 text-center">
                                <button id="saveBtn" type="submit" class="btn btn-primary">保存</button>
                                <button type="button" class="btn btn-danger" onclick="window.location.reload();">取消</button>
                            </div>
                        </c:if>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
