<!--module-->
<script>

    $(function () {
        $('#editModal').on('show.bs.modal', function (event) {
            $.get(URL_GET, loadEdit);
            $("#e_roleId").closest('div').hide();

        })

        $('#editModal').on('hide.bs.modal', function (event) {
            clearEdit();
            $.get(URL_GET, loadProfile);
        })
    });

</script>

<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editModalLabel">Edit profile</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body px-0">
                <!--edit block-->
                <%@include file="edit.jsp" %>
            </div>
        </div>
    </div>
</div>