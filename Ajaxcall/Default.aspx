<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Ajaxcall.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
    
   <%-- <script type="text/javascript" src="myScript.js"></script>--%>
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
    <script type="text/javascript">
        //==== Method to save data into database.
        function saveData() {

            //==== Call validateData() Method to perform validation. This method will return 0 
            //==== if validation pass else returns number of validations fails.

            var errCount = validateData();
            //==== If validation pass save the data.
            if (errCount == 0) {
                var txtName = $("#txtName").val();
                var txtEmail = $("#txtEmail").val();
                var txtAge = $("#txtAge").val();
                $.ajax({
                    type: "POST",
                    url: "Default.aspx/saveData",
                    data: "{name:'" + txtName + "',email:'" + txtEmail + "',age:'" + txtAge + "'}",
                    contentType: "application/json; charset=utf-8",
                    datatype: "jsondata",
                    async: "true",
                    success: function (response) {
                        $(".errMsg ul").remove();
                        var myObject = eval('(' + response.d + ')');
                        if (myObject > 0) {
                            bindData();

                            $(".errMsg").append("<ul><li>Data saved successfully</li></ul>");
                        }
                        else {
                            $(".errMsg").append("<ul><li>Opppps something went wrong.</li></ul>");
                        }
                        $(".errMsg").show("slow");
                        clear();
                    },
                    error: function (response) {
                        alert(response.status + ' ' + response.statusText);
                    }
                });
            }
        }
        //==== Method to validate textboxes
        function validateData() {

            var txtName = $("#txtName").val();
            var txtEmail = $("#txtEmail").val();
            var txtAge = $("#txtAge").val();
            var errMsg = "";
            var errCount = 0;
            if (txtName.length <= 0) {
                errCount++;
                errMsg += "<li>Please enter Name.</li>";
            }
            if (txtEmail.length <= 0) {
                errCount++;
                errMsg += "<li>Please enter Email.</li>";
            }
            if (txtAge.length <= 0) {
                errCount++;
                errMsg += "<li>Please enter Age.</li>";
            }
            if (errCount > 0) {

                $(".errMsg ul").remove();//;
                $(".errMsg").append("<ul>" + errMsg + "</ul>");
                $(".errMsg").slideDown('slow');
            }
            return errCount;
        }
        //==== Get data from database, created HTML table and place inside #divData
        function bindData() {
            debugger;
            $.ajax({
                type: "POST",
                //url: location.pathname + "Default.aspx/getData",
                url: "Default.aspx/getData",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                datatype: "jsondata",
                async: "true",
                success: function (response) {
                    var msg = eval('(' + response.d + ')');
                    console.log(msg.length);
                    if ($('#tblResult').length != 0) // remove table if it exists
                    { $("#tblResult").remove(); }
                    var table = "";
                    table += '<table class="tblResult" id="tblResult"><thead> <tr><th>Id</th><th>Name</th><th>Email</th><th>Age</th><th>Actions</th></tr></thead>'
                    for (var i = 0; i <= (msg.length - 1); i++) {
                        var row = "";
                        row += '';
                        row += '';
                        row += '';
                        row += '';

                        row += '';
                        table += row;

                        table += ' <tbody><tr><td>' + msg[i].Id + '</td><td>' + msg[i].Name + '</td><td>' + msg[i].Email + '</td><td>' + msg[i].Age + '</td><td><img src="edit.jpg" height="35px" title="Edit record." onclick="bindRecordToEdit(' + msg[i].Id + ')">  <img src="delete.png" onclick="deleteRecord(' + msg[i].Id + ')" height="35px" title="Delete record."></td></tr></tbody>';
                   // console.log(table);
                   
                    }
                     $('#divData').html(table);
                     $("#divData").slideDown("slow");
                },
                error: function (response) {
                    alert(response.status + ' ' + response.statusText);
                }
            });
        }
        //==== Method to clear input fields
        //second bind method
        function load_RND_Data() {
            debugger;
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "Default.aspx/getData",
                data: "{}",
                dataType: 'JSON',
                async: "true",
                success: function (data) {
                    var msg = eval('(' + data.d + ')');
                    if ($('#tblDetails').length != 0) // remove table if it exists
                    { $("#tblDetails").empty(); }
                    //$("#tblDetails").remove(); // remove() used when table generate at runtime after remove() eg.above binddata() method.
                    console.log(msg.length);
                    $('#tblDetails').append("<tr><th>Id </th><th>Name </th><th>Email</th><th>Age</th></tr>")
                    for (var i = 0; i < msg.length; i++) {
                        $('#tblDetails').append("<tr><td>" + msg[i].Id + "</td><td>" + msg[i].Name + "</td><td>" + msg[i].Email + "</td><td>" + msg[i].Age + "</td></tr>")
                    };

                },
                error: function () {
                    alert("Error");
                }
            });
            return false;
        };
        // bind method end
        function clear() {
            $("#txtName").val("");
            $("#txtEmail").val("");
            $("#txtAge").val("");

            //=== Hide update button and show save button.
            $("#btnSave").show();
            $("#btnUpdate").hide();
        }
        //==== Method to bind values of selected record into input controls for update operation.
        function bindRecordToEdit(id) {
            debugger;
            $.ajax({
                type: "POST",
                url: "Default.aspx/bindRecordToEdit",
                data: "{id:'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                datatype: "jsondata",
                async: "true",
                success: function (response) {
                    var msg = eval('(' + response.d + ')');
                    $("#txtName").val(msg.Name);
                    $("#txtEmail").val(msg.Email);
                    $("#txtAge").val(msg.Age);

                    //=== store id of the selected record in hidden field so that we can use it later during 
                    //=== update process.
                    $("#hfSelectedRecord").val(id);

                    //=== Hide save button and show update button.
                    $("#btnSave").hide();
                    $("#btnUpdate").css("display", "block");


                },
                error: function (response) {
                    alert(response.status + ' ' + response.statusText);
                }
            });
        }
          //Edit Record second method on button click
        function EditData(empid) {
            debugger;
            empid = $("#txtid").val();
            $.ajax({
                url: 'Default.aspx/Edit',
                type: 'post',
                contentType: 'application/json;charset=utf-8',
                dataType: 'json',
                data: "{Id : '" + empid + "'}",
                success: function (_dt) {
                    console.log(_dt);
                    _dt = JSON.parse(_dt.d);
                    console.log(_dt.d);
                    $("#txtName").val(_dt[0].Name);
                    $("#txtEmail").val(_dt[0].Email);
                    $("#txtAge").val(_dt[0].Age);
                     
                    $("#btnsubmit").val("Update");
                    idd = empid;
                },
                error: function () {
                    alert('edit error !!');
                }
            });
        }
        //==== Method to update record.
        function updateData() {

            //==== Call validateData() Method to perform validation. This method will return 0 
            //==== if validation pass else returns number of validations fails.

            var errCount = validateData();
            //==== If validation pass save the data.
            if (errCount == 0) {
                var txtName = $("#txtName").val();
                var txtEmail = $("#txtEmail").val();
                var txtAge = $("#txtAge").val();
                var id = $("#hfSelectedRecord").val();
                $.ajax({
                    type: "POST",
                    url: "Default.aspx/updateData",
                    data: "{name:'" + txtName + "',email:'" + txtEmail + "',age:'" + txtAge + "',id:'" + id + "'}",
                    contentType: "application/json; charset=utf-8",
                    datatype: "jsondata",
                    async: "true",
                    success: function (response) {
                        $(".errMsg ul").remove();
                        var myObject = eval('(' + response.d + ')');
                        if (myObject > 0) {
                            bindData();
                            $(".errMsg").append("<ul><li>Data updated successfully</li></ul>");
                        }
                        else {
                            $(".errMsg").append("<ul><li>Opppps something went wrong.</li></ul>");
                        }
                        $(".errMsg").show("slow");
                        clear();
                    },
                    error: function (response) {
                        alert(response.status + ' ' + response.statusText);
                    }
                });
            }
        }
        //====Second  Method to update record.
        function UpdateRecord() {
            //empid = $("#txtid").val();
            $.ajax({
                    url: 'Default.aspx/Update',
                    type: 'post',
                    contentType: 'application/json;charset=utf-8',
                    dataType: 'json',
                    data: "{ID:'" + idd + "',name:'" + $("#txtName").val() + "',age:'" + $("#txtAge").val() + "',email:'" + $("#txtEmail").val() + "'}",
                    success: function () {
                        alert("Update data Successfully");
                         bindData();
                    },
                    error: function () {
                        alert("Update Error");
                    }
 
                });
        }
        //==== Method to delete a record
        function deleteRecord(id) {
            //=== Show confirmation alert to user before delete a record.
            var ans = confirm("Are you sure to delete a record?");
            //=== If user pressed Ok then delete the record else do nothing.
            if (ans == true) {
                $.ajax({
                    type: "POST",
                    url:  "Default.aspx/deleteRecord",
                    data: "{id:'" + id + "'}",
                    contentType: "application/json; charset=utf-8",
                    datatype: "jsondata",
                    async: "true",
                    success: function (response) {
                        //=== rebind data to remove delete record from the table.
                        bindData();
                        $(".errMsg ul").remove();
                        $(".errMsg").append("<ul><li>Record successfully delete.</li></ul>");
                        $(".errMsg").show("slow");
                        clear();
                    },
                    error: function (response) {
                        alert(response.status + ' ' + response.statusText);
                    }
                });
            }
        }
        //Delete Record method 2
       
        
            function DeleteData(empid) {
                empid = $("#txtid").val();
                 var ans = confirm("Are you sure to delete a record?");
            //=== If user pressed Ok then delete the record else do nothing.
                if (ans == true) {
                    $.ajax({
                        url: 'Default.aspx/Delete',
                        type: 'post',
                        contentType: 'application/json;charset=utf-8',
                        dataType: 'json',
                        data: "{Id : '" + empid + "'}",
                        success: function () {
                            alert('delete success !!');
                            bindData();
                        },
                        error: function () {
                            alert('delete error !!');
                        }
                    });
                }
            }
        
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table>
       <tbody><tr>
           <td colspan="2">
               <%--//=== Here we will show error and confirmation messages.--%>
               <div class="errMsg">
               </div>
           </td>
       </tr>
            <tr>
           <td>
               <b>Id</b>
           </td>
           <td>
               <asp:textbox runat="server" id="txtid">
           </asp:textbox></td>
       </tr>
       <tr>
           <td>
               <b>Name</b>
           </td>
           <td>
               <asp:textbox runat="server" id="txtName">
           </asp:textbox></td>
       </tr>
       <tr>
           <td>
               <b>Email</b>
           </td>
           <td>
               <asp:textbox runat="server" id="txtEmail">
           </asp:textbox></td>
       </tr>
       <tr>
           <td>
               <b>Age</b>
           </td>
           <td>
               <asp:textbox runat="server" id="txtAge">
           </asp:textbox></td>
       </tr>
       <tr>
           <td>
                 
           </td>
           <td>
               <input type="button" onclick="saveData()" id="btnSave" value="Save" title="Save" runat="server" />
               <%--//==== We have hide our update button at the initial stage so that only save button is visible at startup.--%>
               <input type="button" onclick="updateData()" id="btnUpdate" value="Update" title="Update" style="display: none" runat="server" />
               <input type="button" onclick=" bindData()" id="btnshow" value="Show" title="Show" runat="server" />
               <input type="button" onclick=" load_RND_Data()" id="btnshow2" value="Show2" title="Show2" runat="server" />
                <input type="button" onclick="EditData() " id="btnedit" value="Edit" title="Edit" runat="server" />
               <input type="button" onclick="UpdateRecord() " id="btnupdate2" value="Update" title="Update" runat="server" />
               <input type="button" onclick="DeleteData() " id="btndeletenew" value="Delete" title="Delete" runat="server" />
               <%--//=== We will use this hidden field to store id of selected record during update operation.--%>
               <asp:hiddenfield id="hfSelectedRecord" runat="server">
           </asp:hiddenfield></td>
       </tr>
       <tr>
           <td colspan="2">
               <%--//==== We will show our data in this div--%>
               <div id="divData">
               </div>
           </td>
       </tr>
   </tbody></table>
            <div>
                <asp:GridView ID="grd" runat="server"></asp:GridView>
            </div>
        </div>
        <div>
            <table id="tblDetails" class="tblDetails">
            <%-- <tbody id="tblDetails" style="border-color:springgreen"></tbody>--%>
        </table>
        </div>
    </form>
</body>
</html>
