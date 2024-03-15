// Important Point--
//== is used for comparison between two variables irrespective of the datatype of variable.
// === is used for comparision between two variables but this will check strict type, which means it will check datatype and compare two values.
//==== Method to save data into database.
function saveData() {

    //==== Call validateData() Method to perform validation. This method will return 0 
    //==== if validation pass else returns number of validations fails.

    var errCount = validateData();
    //==== If validation pass save the data.//ashok ==0
    if (errCount === 0) {
        var txtName = $("#txtName").val();
        var txtEmail = $("#txtEmail").val();
        var txtAge = $("#txtAge").val();
        $.ajax({
            type: "POST",
            url: location.pathname + "Default.aspx/saveData",
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

    $.ajax({
        type: "POST",
        url: location.pathname + "Default.aspx/getData",
        data: "{}",
        contentType: "application/json; charset=utf-8",
        datatype: "jsondata",
        async: "true",
        success: function (response) {
            var msg = eval('(' + response.d + ')');
            if ($('#tblResult').length !== 0) // remove table if it exists//ashok !=0
            { $("#tblResult").remove(); }
            var table = "";
            for (var i = 0; i <= (msg.length - 1); i++) {
                var row = "";
                row += '';
                row += '';
                row += '';
                row += '';

                row += '';
                table += row;
            }
            table += '<table class="tblResult" id="tblResult"><thead> <tr><th>Name</th><th>Email</th><th>Age</th><th>Actions</th></tr></thead>  <tbody><tr><td>' + msg[i].Name + '</td><td>' + msg[i].Email + '</td><td>' + msg[i].Age + '</td><td><img src="edit.png" title="Edit record." onclick="bindRecordToEdit(' + msg[i].Id + ')">  <img src="delete.png" onclick="deleteRecord(' + msg[i].Id + ')" title="Delete record."></td></tr></tbody></table>';
            $('#divData').html(table);
            $("#divData").slideDown("slow");

        },
        error: function (response) {
            alert(response.status + ' ' + response.statusText);
        }
    });
}
//==== Method to clear input fields
function clear() {
    $("#txtName").val("");
    $("#txtEmail").val("");
    $("#txtAge").val("");

    //=== Hide update button and show save button.
    $("#btnSave").show();
    $("#btnUpdate").hide();
}