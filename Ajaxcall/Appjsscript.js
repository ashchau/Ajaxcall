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
function clear() {
    $("#txtName").val("");
    $("#txtEmail").val("");
    $("#txtAge").val("");

    //=== Hide update button and show save button.
    $("#btnSave").show();
    $("#btnUpdate").hide();
}
//==== Method to save data into database.
function saveData() {

    //==== Call validateData() Method to perform validation. This method will return 0 
    //==== if validation pass else returns number of validations fails.

    var errCount = validateData();
    //==== If validation pass save the data.

    if (errCount === 0) {
        var txtName = $("#txtName").val();
        var txtEmail = $("#txtEmail").val();
        var txtAge = $("#txtAge").val();
        $.ajax({
            type: "POST",
            url: "AjaxcallbyScript.aspx/InsertData",
            data: "{name:'" + txtName + "',email:'" + txtEmail + "',age:'" + txtAge + "'}",  //name: email: age: these variable come from the method InsertData
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
// Method for bind data in table
function bindData() {
    debugger;
    $.ajax({
        type: "POST",
        url: "AjaxcallbyScript.aspx/GetEmpData",
        data: "{}",
        contentType: "application/json; charset=utf-8",
        datatype: "jsondata",
        async: "true",
        success: function (response) {
            console.log(response);
            var msg = eval('(' + response.d + ')');
            if ($('#tblResult').length !== 0) // remove table if it exists//ashok !=0
            { $("#tblResult").remove(); }
            var table = '<table class="tblResult" id="tblResult"><thead> <tr><th>Name</th><th>Email</th><th>Age</th><th>Actions</th></tr></thead>';
            for (var i = 0; i <= (msg.length - 1); i++) {
                var row = "";
                row += '';
                row += '';
                row += '';
                row += '';

                row += '';
                table += row;
                table += '  <tbody><tr><td>' + msg[i].Name + '</td><td>' + msg[i].Email + '</td><td>' + msg[i].Age + '</td><td><img src="edit.jpg" height="35px" title="Edit record." onclick="bindRecordToEdit(' + msg[i].Id + ')">  <img src="delete.png" height="35px" onclick="deleteRecord(' + msg[i].Id + ')" title="Delete record."></td></tr></tbody>';
            }

            $('#divData').html(table);
            $("#divData").slideDown("slow");

        },
        error: function (response) {
            alert(response.status + ' ' + response.statusText);
        }
    });
}
 //==== Method to bind values of selected record into input controls for update operation.
function bindRecordToEdit(id) {
    debugger;
    $.ajax({
        type: "POST",
       // url: location.pathname + "AjaxcallbyScript.aspx/BindRecordToEdit",
        url:  "AjaxcallbyScript.aspx/BindRecordToEdit",
        data: "{id:'" + id + "'}",
        contentType: "application/json; charset=utf-8",
        datatype: "jsondata",
        async: "true",
        success: function (data) {
            var msg1 = eval('(' + data.d + ')');
            console.log(msg1);
            $("#txtName").val(msg1[0].Name);
            $("#txtEmail").val(msg1[0].Email);
            $("#txtAge").val(msg1[0].Age);

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
//===Method to update record
function updateData() {

    //==== Call validateData() Method to perform validation. This method will return 0 
    //==== if validation pass else returns number of validations fails.
    debugger;
    var errCount = validateData();
    //==== If validation pass save the data.
    if (errCount === 0) {
        var txtName = $("#txtName").val();
        var txtEmail = $("#txtEmail").val();
        var txtAge = $("#txtAge").val();
        var id = $("#hfSelectedRecord").val();
        $.ajax({
            type: "POST",
            url: "AjaxcallbyScript.aspx/UpdateData",
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
//==== Method to delete a record
function deleteRecord(id) {
    //=== Show confirmation alert to user before delete a record.
    var ans = confirm("Are you sure to delete a record?");
    //=== If user pressed Ok then delete the record else do nothing.
    if (ans === true) {
        $.ajax({
            type: "POST",
            url: "AjaxcallbyScript.aspx/Delete",
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