<!--modale profile-->
<script>

    var user_url;
    //appear function

    $(function (){
        //when close modal then update item in list
        $('#profileModal').on('hidden.bs.modal', function (event) {
            $.get(user_url, function (data) {
                var tr = $("#" + data.userId);
                tr.find("td:eq(0)").find("img").attr('src', 'data:image/jpeg;base64,' + data.photo);
                tr.find("td:eq(1)").html(data.role);
                tr.find("td:eq(2)").html(data.login);
                tr.find("td:eq(3)").html(data.email);
            });
            user_url = undefined;
        });

        $('#btn_profile').on("click",function () {
            $(this).addClass("active");
            $('#btn_edit').removeClass("active");
            $('#profile').show("slow");
            $('#edit').hide("slow");
            $.get(user_url, loadProfile);
        });

        $('#btn_edit').on("click",function () {
            clearEditForm();
            clearEdit();
            $(this).addClass("active");
            $('#btn_profile').removeClass("active");
            $('#profile').hide("slow");
            $('#edit').show("slow");
            $.get(user_url, loadEditForm);
        });

    });

    function modalProfileShows(id) {
        $('#profileModal').modal("show");
        console.log(id);
        if(id != undefined) {
            user_url = URL_GET_USER_ID + id;
        } else {
            user_url = URL_GET_USER;
        }
        console.log(user_url);

        //default setting
        $.get(user_url, loadProfile);

        $('#profile').show();
        $('#edit').hide();

        $('#btn_profile').removeClass("active");
        $('#btn_edit').removeClass("active");

        $('#btn_profile').addClass("active");
    }

</script>
<div class="modal fade" id="profileModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editModalLabel">Profile</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!--navigation-->
                <div class="col-12">
                    <ul class="nav nav-tabs">
                        <li class="nav-item">
                            <button type="button" class="btn btn-link nav-link" id="btn_profile">Profile</button>
                        </li>
                        <li class="nav-item">
                            <button type="button" class="btn btn-link nav-link" id="btn_edit">Edit</button>
                        </li>
                    </ul>

                </div>
                <!--profile block-->
                <div id="profile">
                    <%@include file="info.jsp" %>
                </div>
                <!--edit block-->
                <div id="edit">
                    <%@include file="edit.jsp" %>
                </div>
            </div>
        </div>
    </div>
</div>