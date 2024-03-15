<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Ajaxexample.aspx.cs" Inherits="Ajaxcall.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        function ShowCurrentTime() {
            $.ajax({
                type: "POST",
                url: "Ajaxexample.aspx/GetCurrentTime",
                data: '{name: "' + $("#<%=txtUserName.ClientID%>")[0].value + '" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    alert(response.d);
                }
            });
        }
        function OnSuccess(response) {
            alert(response.d);
        }
    </script>

    <script>
        function openForm() {
            document.getElementById("myForm").style.display = "block";
        }

        function closeForm() {
            document.getElementById("myForm").style.display = "none";
        }
    </script>

    <script type="text/javascript">
        $(function () {
            $('#btnSubmit').click(function () {
                var name = $('#<%=txtname.ClientID%>')[0].value;
        var psw = $('#txt_psw').val();
        var psw1 = $('#<%=txtpassword.ClientID%>')[0].value;
        //var postData = JSON.stringify({ "username": JSON.stringify($("#txt_email").val()), "password": JSON.stringify($("#txt_psw").val()) });
                if (name != '' && psw1 != '') {
                    debugger;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Ajaxexample.aspx/login",
                data: "{'username':'" + name + "','password':'" + psw1 + "'}",
                //data: postData,
                dataType: "json",
                success: function (data) {
                    //alert(data.d);
                    var obj = data.d;
                    if (obj == 'True') {
                        //$('#txtname').val('');
                        //$('#txtpassword').val('');
                        //$('#txtname').value('');
                        //$('#txtpassword').value('');
                         $('#' + '<%= txtname.ClientID%>').val('');
                         $('#' + '<%= txtpassword.ClientID%>').val('');
                        $('#lblmsg').html("Details Submitted Successfully");
                         $("#lblmsg").css("color", "red");
                        //window.location.reload();
                        //window.location = "http://localhost:51642/ajaxinsert.aspx";
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

    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
        }

        * {
            box-sizing: border-box;
        }

        /* Button used to open the contact form - fixed at the bottom of the page */
        .open-button {
            background-color: #555;
            color: white;
            padding: 16px 20px;
            border: none;
            cursor: pointer;
            opacity: 0.8;
            position: fixed;
            bottom: 23px;
            right: 28px;
            width: 280px;
        }

        /* The popup form - hidden by default */
        .form-popup {
            display: none;
            position: fixed;
            bottom: 0;
            right: 15px;
            border: 3px solid #f1f1f1;
            z-index: 9;
        }

        /* Add styles to the form container */
        .form-container {
            max-width: 300px;
            padding: 10px;
            background-color: white;
        }

            /* Full-width input fields */
            .form-container input[type=text], .form-container input[type=password] {
                width: 100%;
                padding: 15px;
                margin: 5px 0 22px 0;
                border: none;
                background: #f1f1f1;
            }

                /* When the inputs get focus, do something */
                .form-container input[type=text]:focus, .form-container input[type=password]:focus {
                    background-color: #ddd;
                    outline: none;
                }

            /* Set a style for the submit/login button */
            .form-container .btn {
                background-color: #04AA6D;
                color: white;
                padding: 16px 20px;
                border: none;
                cursor: pointer;
                width: 100%;
                margin-bottom: 10px;
                opacity: 0.8;
            }

            /* Add a red background color to the cancel button */
            .form-container .cancel {
                background-color: red;
            }

            /* Add some hover effects to buttons */
            .form-container .btn:hover, .open-button:hover {
                opacity: 1;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        Your Name :
        <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
        <input id="btnGetTime" type="button" value="Show Current Time" onclick="ShowCurrentTime()" />
    </div>
    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
    <button class="open-button" onclick="openForm()">Open Form</button>

    <div class="form-popup" id="myForm">
        <form class="form-container">
            <div class="form-container">

                <label for="email"><b>Email</b></label>
                <input type="text" placeholder="Enter Email" name="email" required runat="server" id="txt_email" />
                <asp:TextBox ID="txtname" runat="server"></asp:TextBox>
                <label for="psw"><b>Password</b></label>
                <input type="password" placeholder="Enter Password" name="psw" required runat="server" id="txt_psw" />
                <asp:TextBox ID="txtpassword" runat="server" TextMode="Password"></asp:TextBox>
                <%--  <asp:Button ID="btnlogin" runat="server" Text="Login1" OnClick="btnlogin_Click" />--%>
                <input type="button" id="btnSubmit" value="Submit" />
                <label id="lblmsg" />
                <br />
                <%--<button type="submit" class="btn" onclick="btnlogin_Click()">Login</button>--%>
                <%-- <input id="Submit1" type="submit" value="submit" onclick="btnlogin_Click()" runat="server" />--%>
                <button type="button" class="btn cancel" onclick="closeForm()">Close</button>

            </div>
        </form>
    </div>

</asp:Content>
