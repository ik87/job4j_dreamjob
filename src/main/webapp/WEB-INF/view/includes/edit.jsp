<script>
    //put data
    function putDataToEdit(data) {
        $("#e_login").val(data.login);
        $("#e_email").val(data.email);
        $("#e_role").val(data.role);
        $("#e_country").val(data.country);
        $("#e_city").val(data.city);
        $("#e_img").attr('data', 'data:image/jpeg;base64,' + data.photo);
        $("#e_id").val(data.userId);
    }

    $(function () {
        $("#uploadImg").click(function () {
            uploadImg(URL_UPLOAD_IMG);
        });

        $("#deleteImg").click(function () {
           deleteImg(URL_DELETE_IMG);
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
                    $("#e_img").attr('data', 'data:image/jpeg;base64,' + data.photo);
                }
            });
        }
    }

    function deleteImg(url) {
        var id = $('#e_id').val();

        $.ajax({
            type: 'POST',
            url: url,
            data: {id: id, action: "deleteImg"},
            dataType: 'text'
        }).done(function (data) {
            $('#e_img').attr('data', 'data:image/jpeg;base64,');
        });
    }


</script>
<div class="container-sm">
    <!--row 1-->
    <div class="row  m-3">
        <!--photo image-->
        <div class="col-12 col-lg-4 mt-3">
            <!--row 2-->

            <!--img-->
            <object class="rounded mx-auto d-block" id="e_img" style="width: 100%"
                    data="" type="image/jpg">
            <img class="rounded mx-auto d-block"  style="width: 100%"
                 src="js/default-user-img.jpg"
            />
            </object>

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
                            <option value="2" selected>User</option>
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
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-primary" id="save" data-dismiss="modal">Save</button>
    </div>
</div>