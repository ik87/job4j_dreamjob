<script>

    $(function () {

        <!-- click save -->
        $('#change').on("click", function () {
            var data = e_credential();
            if (data != null) {
                data.action = "update";
                console.log(data);
                $.post(URL_POST, data).done(function () {
                    $("#danger").hide("slow");
                    $("#success").hide("fast").show("slow");
                }).error(function (data) {
                    $("#success").hide("slow");
                    $("#danger").hide("slow").show("slow");
                });
            } else {
                $("#success").hide("slow");
                $("#danger").hide("fast").show("slow");
            }
        });

        <!-- check password -->
        checkPass("e_passA", "e_passB", "e_displayPassB");

        $("#uploadImg").on("click", function () {
            uploadImg(URL_UPLOAD_IMG);
        });

        $("#deleteImg").on("click", function () {
            deleteImg(URL_POST);
        });


    });



    <!-- upload and delete img-->
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
                    console.log(data);
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

    <!-- put data to form -->
    function loadEditForm(data) {
        $("#e_login").val(data.login);
        $("#e_email").val(data.email);
        $("#e_role").val(data.role);
        $("#e_country").val(data.country);
        $("#e_city").val(data.city);
        $("#e_img").attr('src', 'data:image/jpeg;base64,' + data.photo);
        $("#e_id").val(data.userId);
        $("#e_roleId").val(data.roleId);
    }

    <!-- clear form -->
    function clearEditForm() {
        $("#e_login").val("").removeClass("is-valid");
        $("#e_email").val("").removeClass("is-valid");
        $("#e_role").val("").removeClass("is-valid");
        $("#e_country").val("").removeClass("is-valid");
        $("#e_city").val("").removeClass("is-valid");
        $("#e_img").attr('src', "")
        $("#e_id").val("");
        $("#e_roleId").val("");

        $('#e_passA').val('').removeClass("is-valid");
        $('#e_passB').val('').removeClass("is-valid");

        $('#e_displayPassB').addClass("d-none");
        $('#collapsePass').collapse("hide");

        entityBingMap.searchBoxContainer = '';
        entityBingMap.searchBox = '';
        entityBingMap.countryTbx = '';
        entityBingMap.cityTbx = '';
    }

    <!-- credential block -->
    function e_credential() {
        var data = {
            login: $('#e_login'),
            email: $('#e_email'),
            country: $('#e_country'),
            city: $('#e_city'),
            role_id: $('#e_roleId').val(),
            id: $("#e_id").val(),
        };

        var passA = $('#e_passA');
        var passB = $('#e_passB');

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
    function clearEdit() {
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

        <!--profile form-->
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
                                <label for="e_passA">New password</label>
                                <input type="password" class="form-control" id="e_passA" required>
                                <div id="e_displayPassB" class="d-none">
                                    <label for="e_passB">Repeat new password</label>
                                    <input type="password" class="form-control" id="e_passB" required>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group  col-md-12">
                        <label for="e_searchBox">Enter your city</label>
                        <div id='e_searchBoxContainer'>
                            <input type='text' id='e_searchBox'/>
                        </div>
                        <label for="e_country">Country</label>
                        <input type="text" class="form-control" id="e_country" value="" required disabled>
                        <label for="e_city">City</label>
                        <input type="text" class="form-control" id="e_city" value="" required disabled>
                    </div>
                </div>
            </form>

        </div>
    </div>

<!--button update profile-->
    <div class="modal-footer">
        <div id="success" class="alert alert-success" role="alert">
            Change was saved!
        </div>
        <div id="danger" class="alert alert-danger" role="alert">
            Change was-not saved!
        </div>
        <div>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            <button type="button" class="btn btn-primary" id="change">Change</button>
        </div>
    </div>

</div>