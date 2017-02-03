<%@ Page Language="C#" AutoEventWireup="true" CodeFile="checkSurveyMain.aspx.cs" Inherits="datasubmit_checkSurvey" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery.min.js" type="text/javascript"></script>
    <script src="../js/jquery.easyui.min1.4.js" type="text/javascript"></script> 
    <script src="../js/datagrid-detailview.js" type="text/javascript"></script>
    
       <script type="text/javascript">
           $(function() {
               $("#tab").tabs({ fit: true });
               //addTab('房屋信息', 'crud_tables/show_house.htm');
           });

           function addTab(title, url) {
               if (!$("#tab").tabs("exists", title)) {
                   var content = '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:100%;"></iframe>';
                   $("#tab").tabs("add", {
                       title: title,
                       closable: true,
                       content: content
                   });

               } else {
                   $("#tab").tabs("select", title);
               }
           }

           function goById(id) {
           
               document.getElementById("fcheck").src = "./checkSurvey.aspx?id="+id;
           }

     
    </script>
</head>
<body class="easyui-layout">
<form id="ff"  action="" method="post">   

  <div region="west" title="选择主题" style="width: 250px;" split="true">
    <asp:Repeater ID="Repeater1" runat="server">
   
      <ItemTemplate>
       <li style="list-style-type: square; line-height: 25px; margin-left:5px;padding-left:5px">
       <a href="#" style="cursor: pointer; text-decoration: none;" 
       onclick="goById('<%# DataBinder.Eval(Container.DataItem, "ID") %>')"><%# DataBinder.Eval(Container.DataItem, "NAME") %> </a>
       </li>
     </ItemTemplate>
    
    </asp:Repeater>
            
   </div>


 <div region="center">
<iframe id="fcheck" scrolling="auto" frameborder="0"  src="" style="width:100%;height:100%;"></iframe>
</div>



   
<script type="text/javascript">

    function submitForm() {
        $('#ff').form('submit');
    }
    function clearForm() {
        $('#ff').form('clear');
    }    
</script>
</form> 
</body>
</html> 