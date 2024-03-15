<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ajaxinsert.aspx.cs" Inherits="Ajaxcall.ajaxinsert" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
    <title>Insert data into database using jquery in asp.net</title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.8.2.js"></script>
    <script type="text/javascript">  
    $(function() {  
        $("#btnSave").click(function() {  
            var user = {};  
            user.name = $("#txtname").val(); // name as per name of Employee Class  and txtname is the textbox id 
            user.subject = $("#txtsubject").val();  
            user.description = $("#txtbody").val();   
             
            $.ajax({  
                type: "POST",  
                url: "ajaxinsert.aspx/SaveUser", // ajaxinsert.aspx is the page and SaveUser is the WebMethod to save data in database  
                data: '{objEmployee: ' + JSON.stringify(user) + '}', //objEmployee is the object of Employee Class defined in .cs  
                dataType: "json",  
                contentType: "application/json; charset=utf-8",  
                success: function() {  
                    alert("User has been added successfully.");  
                    //getDetails(); //This method is to bind the added data into my HTML Table through Ajax call instead of page load  
                    // window.location.reload(); we can also use this to load window to show updated data  
                },  
                error: function() {  
                    alert("Error while inserting data");  
                }  
            });  
            return false;  
        });  
    });  
</script> 
    <script type="text/javascript">
        function getDetails() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ajaxinsert.aspx/GetData", //Default.aspx is page and GetData is the WebMethod  
                data: {},
                dataType: "json",
                success: function (data) {
                    $('#dataTables-example tbody').remove(); // Every time I am removing the body of Table and applying loop to display data  
                    //console.log(data.d);    
                    for (var i = 0; i < data.d.length; i++) {
                        $("#dataTables-example").append(
                            "<tr><td>" + data.d[i].name + "</td><td>" + data.d[i].subject + "</td>" +
                            "<td>" + data.d[i].description +  "<td>" + "<input type='button' class='btn btn-primary editButton' data-id='" + data.d[i].subjectid + "' data-toggle='modal' data-target='#myModal' name='submitButton' id='btnEdit' value='Edit' />" + "</td>" +
                            "<td><input type='button' class='btn btn-primary' name='submitButton' id='btnDelete' value='Delete'/> </td></tr>");
                    }
                },
                error: function () {
                    alert("Error while Showing update data");
                }
            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <table>
            <tr>
                <td>Name:</td>
                <td>
                    <input type="text" id="txtname" /></td>
            </tr>
            <tr>
                <td>Subject:</td>
                <td>
                    <input type="text" id="txtsubject" /></td>
            </tr>
            <tr>
                <td>Body:</td>
                <td>
                    <textarea id="txtbody"></textarea></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <input type="button" id="btnSubmit" value="Submit" />
                     <input type="button" id="btnSave" value="Save" />
                    <input type="button" id="btnshow" value="Show" onclick="getDetails()" />
                </td>
            </tr>
        </table>
        <label id="lblmsg" />
        <br />

        <asp:GridView ID="gvDetails" runat="server">
            <HeaderStyle BackColor="#df5015" Font-Bold="true" ForeColor="White" />
        </asp:GridView>
        <%-- create table for bind data start --%>
        <table id="dataTables-example" class="table table-striped table-bordered table-hover dataTable no-footer" role="grid" aria-describedby="dataTables-example_info">  
    <thead>  
        <tr role="row">  
            <th class="sorting_asc" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 175px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column descending">Name</th>  
            <th class="sorting" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 203px;" aria-label="Browser: activate to sort column ascending">Subject </th>  
            <th class="sorting" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 184px;" aria-label="Platform(s): activate to sort column ascending">body</th>   
            <th class="sorting" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="2" style="width: 108px;" aria-label="CSS grade: activate to sort column ascending">Action</th>  
        </tr>  
    </thead>  
    <tbody>  
       <%-- <% for (var data = 0; data < TableData.Rows.Count; data++)    
                                                       { %>  
            <tr class="gradeA odd" role="row">  
                <td class="sorting_1">  
                    <%=TableData.Rows[data]["name"]%>  
                </td>  
                <td>  
                    <%=TableData.Rows[data]["subject"]%>  
                </td>  
                <td>  
                    <%=TableData.Rows[data]["description"]%>  
                </td>  
                
                <td>  
                    <input type="button" class="btn btn-primary editButton" data-id="<%=TableData.Rows[data][" EmpId "] %>" data-toggle="modal" data-target="#myModal" name="submitButton" id="btnEdit" value="Edit" />  
                </td>  
                <td>  
                    <input type="button" class="btn btn-primary" name="submitButton" id="btnDelete" value="Delete" />  
                </td>  
            </tr>  
            <% } %>  --%>
    </tbody>  
</table> 
        <%-- bind table end --%>
    </form>
    <script type="text/javascript">
        $(function () {
            $('#btnSubmit').click(function () {
                var name = $('#txtname').val();
                var subject = $('#txtsubject').val();
                var body = $('#txtbody').val();
                if (name != '' && subject != '' && body) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "ajaxinsert.aspx/InsertData",
                        data: "{'username':'" + name + "','subj':'" + subject + "','desc':'" + body + "'}",
                        dataType: "json",
                        success: function (data) {
                            var obj = data.d;
                            if (obj == 'true') {
                                $('#txtname').val('');
                                $('#txtsubject').val('');
                                $('#txtbody').val('');
                                $('#lblmsg').html("Details Submitted Successfully");
                                window.location.reload();
                                //window.location = "http://localhost:51642//Ajaxexample.aspx";
                            }
                        },
                        error: function (result) {
                            alert("Error");
                        }
                    });
                }
                else {
                    alert('Please enter all the fields')
                    return false;
                }
            })
        });
    </script>


</body>
</html>
