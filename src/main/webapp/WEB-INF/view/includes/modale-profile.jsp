<!--modale profile-->
<script>
    let URL_UPLOAD_IMG = "admin/upload";
    let URL_DELETE_IMG = "admin";
    let URL_GET_USER = "admin/profile?id=";

    //appear function
    function profile(id) {

        //default setting
        $.get(URL_GET_USER + id, putDataToProfile);

        $('#profile').show();
        $('#edit').hide();
        $('#btn_profile').addClass("active");
        $('#btn_edit').removeClass("active");

        $('#profileModal').modal('show');

        $('#btn_profile').click(function () {
            $(this).addClass("active");
            $('#btn_edit').removeClass("active");
            $('#profile').show("slow");
            $('#edit').hide("slow");
            $.get(URL_GET_USER + id, putDataToProfile);
        });

        $('#btn_edit').click(function () {
            $(this).addClass("active");
            $('#btn_profile').removeClass("active");
            $('#profile').hide("slow");
            $('#edit').show("slow");
            $.get(URL_GET_USER + id, putDataToEdit);
        });
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