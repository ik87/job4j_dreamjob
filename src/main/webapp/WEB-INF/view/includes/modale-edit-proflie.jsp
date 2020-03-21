<!--module-->
<script>
    $(function () {
        $('#editModal').on('show.bs.modal', function (event) {
            $('#login').val('${userDto.login}');
            $('#email').val('${userDto.email}');
            $('#password').val('yourpassword');
            $('#city').val('${userDto.city}');
            $('#country').val('${userDto.country}');
            $('#roleId').val('${userDto.roleId}');
        });
        $("#editPassword").click(function () {

            var pass = $('#pass').val();

            var status;
            $.ajax({
                type: 'POST',
                url: "",
                data: {password: pass},
                dataType: 'text'
            }).done(function (data) {
                location.reload();
            }).fail(function (err) {
                $('body').prepend(
                    "<div class='fixed-top alert alert-danger ' role='alert'>" +
                    "Login or password is not correct" +
                    "</div>"
                );
            });

            console.log("edit password");
        })
    });


</script>

<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editModalLabel">Edit profile</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-row">
                        <div class="form-group col-md-12">
                            <label for="login">Login</label>
                            <input type="text" class="form-control" id="login" name="login">
                        </div>
                        <div class="form-group col-md-12">
                            <label for="email">Email</label>
                            <input type="email" class="form-control" id="email" value="" name="email">
                        </div>

                        <c:if test="${user.id  ne  userDto.userId}">
                            <div class="form-group col-md-4">
                                <label for="roleId">Role</label>
                                <select name="role_id" id="roleId" class="form-control">
                                    <option value="2" selected>User</option>
                                    <option value="1">Admin</option>
                                </select>
                            </div>
                        </c:if>
                        <div class="form-group  col-12" id="passwordGroup">
                            <label for="password">Password</label>
                            <div class="input-group ">
                                <div class="input-group-prepend">
                                    <button class="btn btn-outline-secondary" id="editPassword" type="button">Change
                                        password
                                    </button>
                                </div>
                                <input type="password" class="form-control" id="password" disabled>
                            </div>
                        </div>
                        <%--<div class="form-group col-md-12">
                            <button type="button" class="btn btn-danger mb-1">change</button>
                            <label  for="password">Password</label>
                            <input type="password" class="form-control" id="password" value="" name="password">
                        </div>--%>

                        <div class="form-group  col-md-12">
                            <label for="country">Country</label>
                            <input type="text" class="form-control" id="country" value="">
                            <label for="city">City</label>
                            <input type="text" class="form-control" id="city" value="">
                        </div>
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary">Save</button>
            </div>
        </div>
    </div>
</div>