<!--module-->
<script>

    $(function () {
        $('#editModal').on('show.bs.modal', function (event) {
            $('#e_login').val($('#login').html());
            $('#e_email').val($('#email').html());
            $('#e_city').val($('#city').html());
            $('#e_country').val($('#country').html());
            $('#e_roleId').val($('#roleId').html());
        });

        $('#collapsePass').on('show.bs.collapse', function () {
            $('#passA').val('').removeClass("is-valid").addClass("is-invalid");
            $('#passB').val('').removeClass("is-valid").addClass("is-invalid");
            $('#displayPassB').addClass("d-none");

        });


        <!-- check password -->
        $('#passA').keyup(function () {
            if ($(this).val().length > 3) {
                $(this).removeClass("is-invalid").addClass("is-valid");
                $('#displayPassB').removeClass("d-none");
            }
            if ($(this).val().length < 3) {
                $(this).removeClass("is-valid").addClass("is-invalid");
                $('#passB').val('');
                $('#displayPassB').addClass("d-none");
            }
        });

        $('#passB').keyup(function () {
            if ($(this).val() == $('#passA').val()) {
                $(this).removeClass("is-invalid").addClass("is-valid");
            } else {
                $(this).removeClass("is-valid").addClass("is-invalid");
            }
        });

        <!-- click save -->
        $('#save').click(function (event) {
            var data = credential();
            if(data != null) {
                send(data);
            }
        });

        function credential() {
            var data = null;
            var _login = $('#e_login');
            var _email = $('#e_email');
            var _passA = $('#passA');
            var _passB = $('#passB');
            var _country = $('#e_country');
            var _city = $('#e_city');
            var _ruleId = $('#e_roleId option:selected');

            var correct = true;

            //check login
            correct &= check(_login, checkLength);

            //email
            correct &= check(_email, checkEmail);

            //check pass
            if ($('#collapsePass').hasClass('collapse show')) {
                if (check(_passA, checkLength) && check(_passB, checkLength)) {
                    if (_passA.val() != _passB.val()) {
                        check(_passA, x => true);
                        check(_passB, x => true);
                        correct &= false;
                    }
                } else {
                    correct &= false;
                }
            }


            //check country
            correct &= check(_country, checkLength);
            //check city
            correct &= check(_city, checkLength);

            if(correct) {
                data = {
                    login: _login.val(),
                    email: _email.val(),
                    password: _passB.val(),
                    rule_id: _ruleId.val(),
                    country: _country.val(),
                    city: _city.val(),
                    action: 'update',
                    id: '${userDto.userId}'
                }
            }

            return data;
        }

        function send(data) {
            $.ajax({
                type: 'POST',
                url: "${pageContext.request.contextPath}/${sessionScope.user.role.role}",
               //data: JSON.stringify(data),
                data: data,
                //contentType: "application/json",
                dataType: 'text'
            }).done(function (json) {
                var data = JSON.parse(json);
                $("#login").html(data.login);
                $("#email").html(data.email);
                $("#role").html(data.role);
                $("#country").html(data.country);
                $("#city").html(data.city);
                console.log(data);

            }).fail(function (err) {
/*                $('body').prepend(
                    "<div class='fixed-top alert alert-danger ' role='alert'>" +
                    "Login or password is not correct" +
                    "</div>"
                );*/
            });
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


        function checkEmail(email) {
            var re = /\S+@\S+\.\S+/;
            console.log(!re.test(email.val()));
            return !re.test(email.val());
        }


    })
    ;


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

                        <c:if test="${user.id  ne  userDto.userId}">
                            <div class="form-group col-md-4">
                                <label for="e_roleId">Role</label>
                                <select name="role_id" id="e_roleId" class="form-control">
                                    <option value="2" selected>User</option>
                                    <option value="1">Admin</option>
                                </select>
                            </div>
                        </c:if>
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
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="save" data-dismiss="modal">Save</button>
                </div>
            </div>
        </div>
    </div>
</div>