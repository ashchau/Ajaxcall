<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AjaxcallbyScript.aspx.cs" Inherits="Ajaxcall.AjaxcallbyScript" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="Appjsscript.js" type="text/javascript" lang="ja"></script>
    <script>
        //To show data when page initially loads.
        $(document).ready(function () {
            bindData();
        });
    </script>
    <style type="text/css">
       body
       {
           font-family: Verdana;
           font-size: 11px;
       }
        
       .errMsg
       {
           width: 200px;
           text-align: left;
           color: yellow;
           font: 12px arial;
           background: red;
           padding: 5px;
           display: none;
       }
        
       .tblResult
       {
           border-collapse: collapse;
       }
        
       .tblResult td
       {
           padding: 5px;
           border: 1px solid red;
       }
        
       .tblResult th
       {
           padding: 5px;
           border: 1px solid red;
       }
        
       img
       {
           cursor: pointer;
       }
        .tblDetails
       {
           border-collapse: collapse;
       }
        
       .tblDetails td
       {
           padding: 5px;
           border: 1px solid red;
       }
        
       .tblDetails th
       {
           padding: 5px;
           border: 1px solid red;
       }
   </style>
   <%-- <script type="text/javascript">
        function bindData() {
            debugger;
            $.ajax({
                type: "POST",
                url: location.pathname + "AjaxcallbyScript.aspx/GetEmpData",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                datatype: "jsondata",
                async: "true",
                success: function (response) {
                    console.log(response);
                    var msg = eval('(' + response.d + ')');
                    if ($('#tblResult').length !== 0) // remove table if it exists//ashok !=0
                    { $("#tblResult").remove(); }
                    var table =  '<table class="tblResult" id="tblResult"><thead> <tr><th>Name</th><th>Email</th><th>Age</th><th>Actions</th></tr></thead>';
                    for (var i = 0; i <= (msg.length - 1); i++) {
                        var row = "";
                        row += '';
                        row += '';
                        row += '';
                        row += '';

                        row += '';
                        table += row;
                        table +='  <tbody><tr><td>' + msg[i].Name + '</td><td>' + msg[i].Email + '</td><td>' + msg[i].Age + '</td><td><img src="edit.jpg" height="35px" title="Edit record." onclick="bindRecordToEdit(' + msg[i].Id + ')">  <img src="delete.png" height="35px" onclick="deleteRecord(' + msg[i].Id + ')" title="Delete record."></td></tr></tbody>';
                    }
                    
                    $('#divData').html(table);
                    $("#divData").slideDown("slow");

                },
                error: function (response) {
                    alert(response.status + ' ' + response.statusText);
                }
            });
        }
    </script>--%>
</head>
<body>
    <form id="form1" runat="server">
        <div id="divData">
        </div>
        <table>
            <tbody>
                
                <%--<tr>
                    <td>
                        <b>Id</b>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtid">
                        </asp:TextBox></td>
                </tr>--%>
                <tr>
                    <td>
                        <b>Name</b>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtName">
                        </asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        <b>Email</b>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtEmail">
                        </asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        <b>Age</b>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtAge">
                        </asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                         <%--//=== We will use this hidden field to store id of selected record during update operation.--%>
                         <asp:hiddenfield id="hfSelectedRecord" runat="server"></asp:hiddenfield>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <%--//=== Here we will show error and confirmation messages.--%>
                        <div class="errMsg">
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
        <div>
            <input type="button" onclick="saveData()" id="btnSave" value="Save" title="Save" runat="server" />
               <%--//==== We have hide our update button at the initial stage so that only save button is visible at startup.--%>
               <input type="button" onclick="updateData()" id="btnUpdate" value="Update" title="Update" style="display: none" runat="server" />
             <input type="button" onclick="bindData()" id="btnshow" value="Show" title="Show" runat="server" />
        </div>
    </form>
</body>
</html>
