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
        $(function(){
            initroleGrid();
            initUserEditWin();
            queryUser();
            initUserRole();
            userRoleEditWin();
            initDistributeWin();
        });
        function initroleGrid(){
            $("#roleGrid").datagrid({
                fit:true,
                rownumbers:true,
                singleSelect:true,
                autoRowHeight:false,
                pagination:true,
                fitColumns:true,
                pageSize:2,
                pageList:[2,10,20,30,40],
                //pageSize和pageList必须结合时候用，pageList的默认值是[10,20,30,40,50]
                //并且pageSize的默认值就是10 。如果修改了pageSize的值，那么这个值必须在pageList中出现
                fitColumns:true,
                toolbar:"#roletb",
               /* treeField: 'authname',*/
                columns:[[
                    {field:'username',title:'用户名',width:60},
                    {field:'realname',title:'真实姓名',width:60},
                    {field:'phone',title:'电话号码',width:60},
                    {field:'email',title:'电子邮件',width:60},
                    {field:'status',title:'类型',width:60,
                        formatter: function(value,row,index){
                            if (value=="1"){
                                return "有效";
                            } else {
                                return "无效";
                            }
                        }
                    },
                    {field:'id',title:'操作',width:60,
                        formatter: function(value,row,index){
                                return "<a href='javascript:void(0)' onclick='showDistributeWin("+value+")'>分配角色</a>"
                        }
                    },
                ]],
                onDblClickRow:function(index, row){
                    console.log(row);
                    $('#userEditWin').window("open");
                    $("#id").val(row.id);
                    $("#username").textbox("setValue", row.username);
                    $("#realname").textbox("setValue", row.realname);
                    $("#status").combobox("setValue",row.status);
                }
            })
        };
        function queryUser(){
            var username=$("#query_username").textbox("getValue");
            var realname=$("#query_realname").textbox("getValue");
            var status=$("#query_status").combobox("getValue");
            console.log(username);
            console.log(realname);
            console.log(status);
            console.log($("#roleGrid").datagrid("options"));
            //设置参数
            $("#roleGrid").datagrid("options").queryParams={
                username:username,
                realname:realname,
                status:status
            }
            //指定请求数据的路径
            $("#roleGrid").datagrid("options").url=path+"/user/queryUser";
            //返送请求，获取数据
            $("#roleGrid").datagrid("load");

        };
        function openUserAddWin(){
            $('#userEditWin').window("open");
        }
        function closeUserEditWin(){
            $('#userEditWin').window("close");
        }
        function initUserEditWin() {
            $('#userEditWin').window({
                title: "用户编辑窗口",
                modal: true,
                closed: true,
                iconCls: 'icon-edit',
                width: 300,
                height: 350,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                resizable: false,
                footer: "#footer",
                onBeforeClose: function () {
                    $("#id").val("");
                    $("#username").textbox("setValue", "");
                    $("#realname").textbox("setValue", "");
                    $("#status").combobox("setValue","1");
                    $("#phone").textbox("setValue", "");
                    $("#email").textbox("setValue", "");
                }
            });
        }
        function submitUser(){
            var id=$("#id").val();
            var username=$("#username").textbox("getValue");
            var realname=$("#realname").textbox("getValue");
            var status=$("#status").combobox("getValue");
            var phone=$("#phone").textbox("getValue");
            var email=$("#email").textbox("getValue");
            if(username=="" ||realname==""||phone==""||email=="" ){
                $.messager.alert("提示","所有内容均为必填项");
                return;
            }
            $.ajax({
                url:path+"/user/saveOrUpdateUser",
                type:"post",
                dataType:"json",
                data:{
                    id:id,
                    username:username,
                    realname:realname,
                    status:status,
                    phone:phone,
                    email:email,
                },
                success:function(result){
                    if(result.success){
                        $.messager.alert("提示",result.info,"",function(){
                            closeUserEditWin();
                            queryUser();
                        });
                    }else{
                        $.messager.alert("提示",result.info);
                    }
                }
            })
        }
        function initUserRole(){
            $("#userRoleWin").datagrid({
                fit:true,
                iconCls: 'icon-ok',
                rownumbers: true,
                animate: true,
                collapsible: true,
                fitColumns: true,
                url:path+"/role/queryRole2",
                method: 'get',
                idField: 'id',
                treeField: 'rolename',
               /* toolbar:"#roletb",*/
                columns:[[
                    {field:'',title:'角色名称',width:100,checkbox:true},
                    {field:'rolename',title:'角色名称',width:100}
                ]]
            })
        }
        function userRoleEditWin() {
            $('#userRoleEditWin').window({
                title: "用户编辑窗口",
                modal: true,
                closed: true,
                iconCls: 'icon-edit',
                width: 300,
                height: 350,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                resizable: false,
                footer: "#footer",
                onBeforeClose: function () {
                    $("#id").val("");
                    $("#username").textbox("setValue", "");
                    $("#realname").textbox("setValue", "");
                    $("#status").combobox("setValue","1");
                    $("#phone").textbox("setValue", "");
                    $("#email").textbox("setValue", "");
                }
            });
        }
        function closeDistributeWin(){
            $('#distributeWin').window("close");
        }

        function initDistributeWin() {
            $('#distributeWin').window({
                title: "角色分配窗口",
                modal: true,
                closed: true,
                iconCls: 'icon-edit',
                width: 350,
                height: 300,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                footer: "#footer2",
                onBeforeClose: function () {
                    $("#userid").val("");

                }
            });
        }
        function showDistributeWin(userid){
            $('#distributeWin').window("open");
            $("#userid").val(userid);
            initroleDistributeGrid(userid);

        }

        function initroleDistributeGrid(userid){
            $("#roleDistributeGrid").datagrid({
                fit:true,
                rownumbers:true,
                singleSelect:false,
                url:path+"/role/queryRoleByUserId?userid="+userid,
                autoRowHeight:false,
                pagination:false,
                fitColumns:true,
                columns:[[
                    {field:'id',title:'',checkbox:true},
                    {field:'rolename',title:'角色名称',width:100},
                    {field:'rolecode',title:'角色编码',width:100},
                    {field:'checked',title:'是够勾选',width:100}
                ]],
                onLoadSuccess:function(data){
                    console.log(data);
                    var rows=data.rows;
                    for(var i=0; i<rows.length; i++){
                        var row=rows[i];
                        if(row.checked){
                            $("#roleDistributeGrid").datagrid("selectRow",i);
                        }
                    }
                }

            })


        }
        function submitDistribute(){
            var userid=$("#userid").val();
            var checked=$("#roleDistributeGrid").datagrid("getChecked");
            if(checked.length==0){
                $.messager.alert("提示","请至少选择一个角色");
                return;
            }
            console.log(checked);
            var roleids=[];
            for(var i=0; i<checked.length;i++){
                roleids.push(checked[i].id);
            }
            $.ajax({
                url:path+"/user/distribute",
                type:"post",
                dataType:"json",
                traditional:true,
                data:{
                    roleids:roleids,
                    userid:userid
                },
                success:function(result){
                    if(result.success){
                        $.messager.alert("提示",result.info,"",function(){
                            closeDistributeWin();
                        });
                    }else{
                        $.messager.alert("提示",result.info);
                    }
                }
            });
        }
    </script>
</head>
<body>

<table id="roleGrid">
    <div id="roletb" style="padding:2px 5px;">
        用户名称: <input id="query_username" class="easyui-textbox" style="width:110px">
        用户姓名: <input id="query_realname" class="easyui-textbox" style="width:110px">
        状态:
        <select id="query_status" class="easyui-combobox" data-options="editable:false" panelHeight="auto" style="width:100px">
            <option value="">全部</option>
            <option value="1">有效</option>
            <option value="2">无效</option>
        </select>
        <a href="#" class="easyui-linkbutton" onclick="queryUser()" iconCls="icon-search">搜 索</a>
        <a href="#" class="easyui-linkbutton" onclick="openUserAddWin()" iconCls="icon-add">增 加</a>

    </div>
</table>
    <div id="userRoleEditWin" style="padding:10px 10px;" align="center">
        <table id="userRoleWin" ></table>
    </div>
<div id="userEditWin" style="padding:10px 10px;" align="center">
    <input type="hidden" id="id">
    <div style="margin-bottom:10px">
        <input class="easyui-textbox" id="username" label="用户名称:" labelPosition="left" style="width:90%;">
    </div>
    <div style="margin-bottom:10px">
        <input class="easyui-textbox" id="realname" label="真实姓名:" labelPosition="left" style="width:90%;">
    </div>
    <div style="margin-bottom:10px">
        <select class="easyui-combobox" id="status" label="状态:" data-options="panelHeight:'auto',editable:false" labelPosition="left" style="width:90%;">
            <option value="1">有效</option>
            <option value="2">无效</option>
        </select>
    </div>
    <div style="margin-bottom:10px">
        <input class="easyui-textbox" id="phone" label="电话号码:" labelPosition="left" style="width:90%;">
    </div>
    <div style="margin-bottom:10px">
        <input class="easyui-textbox" id="email" label="电子邮箱:" labelPosition="left" style="width:90%;">
    </div>
</div>
<div id="footer" style="padding:5px;" align="center">
    <a href="#" class="easyui-linkbutton" onclick="submitUser()" data-options="iconCls:'icon-ok'">提 交</a>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="#" class="easyui-linkbutton" onclick="closeUserEditWin()" data-options="iconCls:'icon-cancel'">取 消</a>
</div>
<div id="distributeWin"  >
    <input type="hidden" id="userid">
    <table id="roleDistributeGrid" ></table>
</div>
<div id="footer2" align="center">
    <a href="#" class="easyui-linkbutton" onclick="submitDistribute()" data-options="iconCls:'icon-ok'">提 交</a>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="#" class="easyui-linkbutton" onclick="closeDistributeWin()" data-options="iconCls:'icon-cancel'">取 消</a>
</div>
</body>
</html>
