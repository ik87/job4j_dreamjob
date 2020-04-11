<!--module add-->
<script>
    $(function (){

        $('#addModal').on('show.bs.modal', function (event) {
            clearAddFormUser();
            $("#add_success").hide();
            $("#add_failure").hide();
        });

          <!-- click Add -->
        $('#add').on("click", addUser);
        <!-- check password -->
        checkPass("a_passA", "a_passB", "a_displayPassB");

});

    function addUser() {
        var data = a_credential();
        if (data != null) {
            data.action = "add";
            $.post(URL_POST, data).done(function (json) {
                $("#add_failure").hide("slow");
                $("#add_success").hide("fast").show("slow");
                console.log(json);
                addToTable(json);
            }).error(function () {
                $("#add_success").hide("slow");
                $("#add_failure").hide("fast").show("slow");
            });
        } else {
            $("#add_success").hide("slow");
            $("#add_failure").hide("fast").show("slow");
        }

    }

    function a_credential() {
        var data = {
            login: $('#a_login'),
            email: $('#a_email'),
            country: $('#a_country'),
            city: $('#a_city'),
            role_id: $('#a_roleId').val(),
            id: $("#a_id").val(),
        };

        var passA = $('#a_passA');
        var passB = $('#a_passB');

        var correct = true;

        //check login
        correct &= check(data.login, checkLength);

        //email
        correct &= check(data.email, checkEmail);

        //check country
        correct &= check(data.country, checkLength);
        //check city
        correct &= check(data.city, checkLength);


        //check pass
        if (check(passA, checkLength) && check(passB, checkLength)) {
            if (passA.val() != passB.val()) {
                check(passA, x => true);
                check(passB, x => true);
                correct &= false;
            }
        } else {
            correct &= false;
        }

        data.login = data.login.val();
        data.email = data.email.val();
        data.password = passB.val();
        data.country = data.country.val();
        data.city = data.city.val();

        return correct ? data : null;
    }

    <!-- clear form -->
    function clearAddFormUser() {
        $("#a_login").val("").removeClass("is-valid");
        $("#a_email").val("").removeClass("is-valid");
        $("#a_role").val("").removeClass("is-valid");
        $("#a_country").val("").removeClass("is-valid");
        $("#a_city").val("").removeClass("is-valid");
        $("#a_id").val("");
        $("#a_roleId").val("");

        $('#a_passA').val('').removeClass("is-valid");
        $('#a_passB').val('').removeClass("is-valid");

        $('#a_displayPassB').addClass("d-none");
    }

    function addToTable(json) {
        $('table tbody tr:last').after(
            '<tr data-toggle="modal" data-target="#profileModal">' +
            '<td><img style="height: 50px" src="data:image/jpeg;base64,"' + json.photo +
            `onerror="this.src='js//default-user-img.jpg'"/></td>` +
            '<td>' + json.role + '</td>' +
            '<td>' + json.login + '</td>' +
            '<td>' + json.email + '</td>' +
             '<td>' +
             '<button class="btn btn-link" >remove</button>' +
             '</td>' +
             '</tr>'
        );
        $('table tbody tr:last').attr('id', json.userId);
        $('table tbody tr:last td:last').on('click', function() {
            remove(json.userId);
        });
    }
</script>
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addModalLabel">Add user</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container">
                    <!--row 1-->
                    <form>
                        <div class="form-row">
                            <div class="form-group col-md-12">
                                <label for="a_login">Login</label>
                                <input type="text" class="form-control" id="a_login" name="login" required>
                            </div>
                            <div class="form-group col-md-12">
                                <label for="a_email">Email</label>
                                <input type="email" class="form-control" id="a_email" value="" name="email" required>
                                <div class="valid-feedback">
                                    Looks good!
                                </div>
                            </div>
                            <div class="form-group col-md-4">
                                <label for="a_roleId">Role</label>
                                <select name="role_id" id="a_roleId" class="form-control">
                                    <option value="2">User</option>
                                    <option value="1">Admin</option>
                                </select>
                            </div>
                            <div class="form-group col-12">
                                <!--password -->
                                <label >Password</label>
                                <input type="password" class="form-control" id="a_passA" required>
                                <div id="a_displayPassB" class="d-none">
                                    <label for="a_passB">Repeat password</label>
                                    <input type="password" class="form-control" id="a_passB" required>
                                </div>
                             </div>

                            <div class="form-group  col-md-12">
                                <label for="a_country">Country</label>
                                <input type="text" class="form-control" id="a_country" value="" required>
                                <label for="a_city">City</label>
                                <input type="text" class="form-control" id="a_city" value="" required>
                            </div>
                        </div>
                    </form>
                    <!--button update profile-->
                    <div class="modal-footer">
                        <div id="add_success" class="alert alert-success" role="alert">
                            User was added!
                        </div>
                        <div id="add_failure" class="alert alert-danger" role="alert">
                            User was not added!
                        </div>
                        <div>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary" id="add" data-dismiss="modal">Add</button>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>