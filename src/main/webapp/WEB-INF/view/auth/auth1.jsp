<%--
  Created by IntelliJ IDEA.
  User: 我的电脑
  Date: 2018/11/9
  Time: 14:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/view/commom.jsp" %>
<html>
<head>
    <title>Title</title>

    <script type="text/javascript">
        $(function () {
            initAuthTree();
            initEditAuthTree();
        });
        function initAuthTree() {
            $("#authTree").treegrid({
                fit:true,
                iconCls: 'icon-ok',
                rownumbers: true,
                animate: true,
                collapsible: true,
                fitColumns: true,
                url:path+ '/auth/queryAllAuth',
                method: 'get',
                idField: 'id',
                treeField: 'authname',
                onContextMenu: onContextMenu,
                columns:[[
                    {field:'authname',title:'权限名称',width:180},
                    {field:'authcode',title:'权限编码',width:60},
                    {field:'type',title:'类型',width:80,
                        formatter: function(value,row,index){
                            if (value=="1"){
                                return "模块";
                            } else {
                                return "资源";
                            }
                        }
                    },
                    {field:'url',title:'URL',width:80},
                    {field:'status',title:'状态',width:80,
                        formatter: function(value,row,index){
                            if (value=="1"){
                                return "有效";
                            } else {
                                return "无效";
                            }
                        }},
                    {field:'orders',title:'排序',width:80}
                ]]
            })
        }
        function onContextMenu(e,row){
            if (row){
                e.preventDefault();//阻止了网页默认的右键选项
                $(this).treegrid('select', row.id);
                $('#mm').menu('show',{
                    left: e.pageX,
                    top: e.pageY
                });
            }
        }
        function initreoad() {
            $("#authTree").treegrid("reload");
        };
        function initEditAuthTree() {
            $('#authEditwin').window({
                title: "权限编辑窗口",
                modal: true,
                closed: true,
                iconCls: 'icon-edit',
                width: 400,
                height: 450,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                resizable: false,
                footer: "#footer",
                onBeforeClose: function () {
                    $("#id").val("setValue", "");
                    $("#pid").val("setValue", "");
                    $("#pname").textbox("setValue", "");
                    $("#authname").textbox("setValue", "");
                    $("#authcode").textbox("setValue", "");
                    $("#type").combobox("setValue", "1");
                    $("#url").textbox("setValue", "");
                    $("#status").combobox("setValue", "1");
                    $("#orders").numberbox("setValue", "");

                }
            });
        }
        function shouAuthAddWin() {
            $("#authEditwin").window("open");
            var node=$("#authTree").treegrid("getSelected")
            $("#pname").textbox("setValue",node.authname);
        }
        function closeAuthEditWin() {
            $("#authEditwin").window("close");
        }
        function submitAuth() {
            var id=$("#id").val();
            var pid=$("#pid").val();
            var authname=$("#authname").textbox("getValue");
            var authcode=$("#authcode").textbox("getValue");
            var type=$("#type").combobox("getValue");
            var url=$("#url").textbox("getValue");
            var status=$("#status").combobox("getValue");
            var orders=$("#orders").numberbox("getValue");
            if (authname=="" || authcode=="" || url=="" || orders==""){
                $.messager.alert("提示","都是必填项");
                return;
            }
            $.ajax({
                url:path+"/auth/saveOrUpdateAuth",
                type:"post",
                dataType:"json",
                data:{
                    id:id,
                    pid:pid,
                    authname:authname,
                    authcode:authcode,
                    type:type,
                    url:url,
                    status:status,
                    orders:orders
                },
                success:function (result) {
                    if(result.success){
                       $.messager.alert("提示",result.info,"",function () {
                           closeAuthEditWin();
                       })
                    }else {
                        $.messager.alert("提示",result.info);
                    }
                }
            })
        }
        function shouAuthEditWin() {
            $("#authEditwin").window("open");
        }
    </script>
</head>
<body>
<table id="authTree">
</table>
<div id="mm" class="easyui-menu" style="width:120px;">
    <div onclick="shouAuthAddWin()" data-options="iconCls:'icon-add'">增加子节点</div>
    <div onclick="shouAuthEditWin()" data-options="iconCls:'icon-edit'">编辑子节点</div>
    <div onclick="initreoad()" data-options="iconCls:'icon-reload'">刷新</div>
</div>
<div id="authEditwin" style="width:100%;padding:10px 30px;">
    <input type="hidden" id="id">
    <input type="hidden" id="pid">
    <div style="margin-bottom:10px">
        <input class="easyui-textbox" id="pname" label="上级节点:" labelPosition="left" style="width:100%;" data-options="disabled:true">
    </div>
    <div style="margin-bottom:10px">
        <input class="easyui-textbox" id="authname" label="权限名称:" labelPosition="left" style="width:100%;">
    </div>
    <div style="margin-bottom:10px">
        <input class="easyui-textbox" id="authcode" label="权限编码:" labelPosition="left" style="width:100%;">
    </div>
    <div style="margin-bottom:10px">
       <%-- <input class="easyui-passwordbox" id="repwd" label="类型:" labelPosition="left" style="width:100%;">--%>
        <select class="easyui-combobox" name="state" data-options="panelHeight:'out',editable:false" label="类型:" labelPosition="left" style="width:100%;">
            <option value="AL">模块</option>
            <option value="AK">资源</option>
        </select>
    </div>
    <div style="margin-bottom:10px">
        <input class="easyui-textbox" id="url" label="URL:" labelPosition="left" style="width:100%;">
    </div>
    <div style="margin-bottom:10px">
        <%-- <input class="easyui-passwordbox" id="repwd" label="类型:" labelPosition="left" style="width:100%;">--%>
        <select class="easyui-combobox" id="status" data-options="panelHeight:'out',editable:false" label="状态:" labelPosition="left" style="width:100%;">
            <option value="AL">有效</option>
            <option value="AK">无效</option>
        </select>
    </div>
    <div style="margin-bottom:10px">
        <input class="easyui-numberbox" id="orders" label="排序:" labelPosition="left" style="width:100%;">
    </div>
</div>
<div id="footer" style="padding:5px;" align="center">
    <a href="#" class="easyui-linkbutton" onclick="submitAuth()" data-options="iconCls:'icon-ok'">提 交</a>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="#" class="easyui-linkbutton" onclick="closeAuthEditWin()" data-options="iconCls:'icon-cancel'">取 消</a>
</div>
</body>
</html>
