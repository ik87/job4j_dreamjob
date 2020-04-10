<script>
    //put data
    function putDataToEdit(data) {
        clearEditForm();
        $("#e_login").val(data.login);
        $("#e_email").val(data.email);
        $("#e_role").val(data.role);
        $("#e_country").val(data.country);
        $("#e_city").val(data.city);
        $("#e_img").attr('src', 'data:image/jpeg;base64,' + data.photo);
        $("#e_id").val(data.userId);
        $("#e_roleId").val(data.roleId);
    }

    $(function () {

        $("#uploadImg").on("click", function () {
            uploadImg(URL_UPLOAD_IMG);
        });

        $("#deleteImg").on("click", function () {
            deleteImg(URL_POST);
        });

        <!-- click save -->
        $('#save').on("click", function (event) {
            var data = credential();
            if (data != null) {
                $.post(URL_POST, data).done(function () {
                    $("#danger").hide("slow");
                    $("#success").hide("fast").show("slow");
                }).error(function () {
                    $("#success").hide("slow");
                    $("#danger").hide("slow").show("slow");
                });
            } else {
                $("#success").hide("slow");
                $("#danger").hide("fast").show("slow");
            }
        });

        <!-- check password -->
        $('#passA').on("keyup", function () {
            if ($(this).val().length > 2) {
                $(this).removeClass("is-invalid").addClass("is-valid");
                $('#displayPassB').removeClass("d-none");
            }
            if ($(this).val().length < 2) {
                $(this).removeClass("is-valid").addClass("is-invalid");
                $('#passB').val('');
                $('#displayPassB').addClass("d-none");
            }
        });

        $('#passB').on("keyup", function () {
            if ($(this).val() == $('#passA').val()) {
                $(this).removeClass("is-invalid").addClass("is-valid");
            } else {
                $(this).removeClass("is-valid").addClass("is-invalid");
            }
        });

    });

    function uploadImg(url) {

        var input = $('#inputGroupFile03')[0];
        var file = input.files[0];
        var id = $('#e_id').val();
        var data = new FormData();
        data.append('file', file);
        data.append('id', id);
        if (typeof file !== 'undefined') {
            $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                url: url,
                data: data,
                processData: false,
                contentType: false,
                success: function (data) {
                    $("#e_img").attr('src', 'data:image/jpeg;base64,' + data.photo);
                }
            });
        }
    }

    function deleteImg(url) {
        var id = $('#e_id').val();

        $.post(url, {id: id, action: "deleteImg"})
            .done(function (data) {
                $('#e_img').attr('src', '');
            });
    }

    <!-- credential block -->

    function credential() {
        var data = {
            login: $('#e_login'),
            email: $('#e_email'),
            country: $('#e_country'),
            city: $('#e_city'),
            roleId: $('#e_roleId').val(),
            id: $("#e_id").val(),
            action: "update"
        };

        var passA = $('#passA');
        var passB = $('#passB');

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
        if ($('#collapsePass').hasClass('collapse show')) {
            if (check(passA, checkLength) && check(passB, checkLength)) {
                if (passA.val() != passB.val()) {
                    check(passA, x => true);
                    check(passB, x => true);
                    correct &= false;
                }
            } else {
                correct &= false;
            }
        }

        data.login = data.login.val();
        data.email = data.email.val();
        data.password = passB.val();
        data.country = data.country.val();
        data.city = data.city.val();

        return correct ? data : null;
    }

    function checkEmail(email) {
        var re = /\S+@\S+\.\S+/;
        return !re.test(email.val());
    }

    function check(field, check) {
        var correct = true;
        if (check(field)) {
            correct = false;
            field.removeClass("is-valid").addClass("is-invalid");
        } else {
            field.removeClass("is-invalid").addClass("is-valid");
        }
        return correct;
    }

    function checkLength(el) {
        return el.val().length < 3;
    }

    function clearEditForm() {
        $("#e_login").val("").removeClass("is-valid");
        $("#e_email").val("").removeClass("is-valid");
        $("#e_role").val("").removeClass("is-valid");
        $("#e_country").val("").removeClass("is-valid");
        $("#e_city").val("").removeClass("is-valid");
        $("#e_img").attr('src', "")
        $("#e_id").val("");
        $("#e_roleId").val("");

        $('#passA').val('').removeClass("is-valid");
        $('#passB').val('').removeClass("is-valid");

        $('#displayPassB').addClass("d-none");
        $('#collapsePass').collapse("hide");

        $("#success").hide();
        $("#danger").hide();
    }

</script>
<div class="container-sm">
    <!--row 1-->
    <div class="row  m-3">
        <!--photo image-->
        <div class="col-12 col-lg-4 mt-3">
            <!--row 2-->

            <!--img-->

            <img class="rounded mx-auto d-block" id="e_img" style="width: 100%"
                 onerror="this.src='js//default-user-img.jpg'"/>

            <!--upload img-->
            <from>
                <input id="e_id" type='hidden' name='id'>
                <div class="form-group row">
                    <div class="col-12">
                        <div class="input-group mt-3">
                            <div class="custom-file">
                                <input id="inputGroupFile03" type="file" class="custom-file-input">
                                <label class="custom-file-label" for="inputGroupFile03">Choose file</label>
                            </div>
                        </div>
                    </div>
                </div>
            </from>

            <div class="btn-group mt-1">
                <!--upload img button-->
                <button type="button" class="btn btn-primary" id="uploadImg">upload</button>
                <!--delete img button-->
                <button type="button" class="btn btn-danger" id="deleteImg">delete</button>
            </div>

        </div>

        <!--profile edit-->
        <div class="col-12 col-lg-8">
            <form>
                <div class="form-row">
                    <div class="form-group col-md-12">
                        <label for="e_login">Login</label>
                        <input type="text" class="form-control" id="e_login" name="login" required>
                    </div>
                    <div class="form-group col-md-12">
                        <label for="e_email">Email</label>
                        <input type="email" class="form-control" id="e_email" value="" name="email" required>
                        <div class="valid-feedback">
                            Looks good!
                        </div>
                    </div>
                    <div class="form-group col-md-4">
                        <label for="e_roleId">Role</label>
                        <select name="role_id" id="e_roleId" class="form-control">
                            <option value="2">User</option>
                            <option value="1">Admin</option>
                        </select>
                    </div>
                    <div class="form-group col-12">
                        <label>Password</label>
                        <div class="form-group">
                            <button class="btn btn-primary" type="button" data-toggle="collapse"
                                    data-target="#collapsePass" aria-expanded="false" aria-controls="collapsePass">
                                Change
                                password
                            </button>
                        </div>
                        <!--password collapse-->
                        <div class="collapse col-12" id="collapsePass">
                            <div class="card card-body">
                                <label for="passA">New password</label>
                                <input type="password" class="form-control" id="passA" required>
                                <div id="displayPassB" class="d-none">
                                    <label for="passB">Repeat new password</label>
                                    <input type="password" class="form-control" id="passB" required>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group  col-md-12">
                        <label for="e_country">Country</label>
                        <input type="text" class="form-control" id="e_country" value="" required>
                        <label for="e_city">City</label>
                        <input type="text" class="form-control" id="e_city" value="" required>
                    </div>
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="">
                </div>
            </form>

        </div>
    </div>

    <div class="modal-footer">
        <div id="success" class="alert alert-success" role="alert">
            Change was saved!
        </div>
        <div id="danger" class="alert alert-danger" role="alert">
            Change was-not saved!
        </div>
        <div>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            <button type="button" class="btn btn-primary" id="save">Save</button>
        </div>
    </div>

</div>