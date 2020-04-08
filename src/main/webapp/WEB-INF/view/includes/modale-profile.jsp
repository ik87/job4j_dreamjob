<!--modale profile-->
<script>
    function profile() {
        console.log("clicks")
        $('#profileModal').modal('show');
    }

</script>
<div class="modal fade" id="profileModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editModalLabel">Profile</h5>
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