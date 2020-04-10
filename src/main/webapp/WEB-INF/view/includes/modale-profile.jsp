<!--modale profile-->
<script>

    var current_id;
    //appear function

    $(function (){

        $('#profileModal').on('show.bs.modal', function (event) {
            var tr = $(event.relatedTarget);
            current_id = tr.attr("id");

            //default setting
            $.get(URL_GET_USER + current_id, putDataToProfile);

            $('#profile').show();
            $('#edit').hide();

            $('#btn_profile').removeClass("active");
            $('#btn_edit').removeClass("active");

            $('#btn_profile').addClass("active");

        });

        //when close modal then update item in list
        $('#profileModal').on('hidden.bs.modal', function (event) {
            $.get(URL_GET_USER + current_id, function (data) {
                var tr = $("#" + current_id);
                tr.find("td:eq(0)").find("img").attr('src', 'data:image/jpeg;base64,' + data.photo);
                tr.find("td:eq(1)").html(data.role);
                tr.find("td:eq(2)").html(data.login);
                tr.find("td:eq(3)").html(data.email);
            });
            clearEditForm();
        });

        $('#btn_profile').on("click",function () {
            $(this).addClass("active");
            $('#btn_edit').removeClass("active");
            $('#profile').show("slow");
            $('#edit').hide("slow");
            $.get(URL_GET_USER + current_id, putDataToProfile);
        });

        $('#btn_edit').on("click",function () {
            $(this).addClass("active");
            $('#btn_profile').removeClass("active");
            $('#profile').hide("slow");
            $('#edit').show("slow");
            $.get(URL_GET_USER + current_id, putDataToEdit);
        });

    });

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