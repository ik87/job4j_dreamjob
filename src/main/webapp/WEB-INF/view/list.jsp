<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Users list</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <%--JS--%>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" src="js/credential.js"></script>
    <script type="text/javascript" src="js/bing_map.js"></script>
    <script type="text/javascript" src="js/info-popover.js"></script>
    <script type='text/javascript' src='http://www.bing.com/api/maps/mapcontrol?callback=GetMap' async defer></script>

    <script>
        const URL_UPLOAD_IMG = "admin/upload";
        const URL_POST = "admin";
        const URL_GET_USER_ID = "admin?id=";
        const URL_GET_USER = "admin";
        const URL_SIGNOUT = "signout";

        var sessionUser;

        $(function () {

            //populate table after login
            $.get(URL_GET_USER, function (data) {
                sessionUser = data.sessionUser[0];
                populateTable(data.all, sessionUser).then(initOperations);
            })
            //signout
            $('#signout_btn').on('click', function () {
                $.get(URL_SIGNOUT,function () {
                    location.reload();
                });
            })

            //animation information

            showPopover('#info_btn',1000, 4000, {
                placement: 'bottom',
                content: 'Click me!'
            });

            $('#info_btn').on('click', animInfoPopoverForList);

        });


        async function populateTable(data, current) {
            $.each(data, function (index, item) {
                if(current.userId != data.userId) {
                    var eachrow =
                        '<tr id=' + item.userId + '>' +
                        '<td><img style="height: 50px" src="data:image/jpeg;base64,' + item.photo +
                        `" onerror="this.src='js//default-user-img.jpg'"/></td>` +
                        '<td>' + item.role + '</td>' +
                        '<td>' + item.login + '</td>' +
                        '<td>' + item.email + '</td>' +
                        '<td>' +
                        '<button class="btn btn-link" >remove</button>' +
                        '</td>' +
                        '</tr>'
                    $('tbody').append(eachrow);
                }
            });
        }

        function initOperations() {
            //when click on row
            $('tbody tr td:not(:last-child)').on('click',function () {
                var tr = $(this).closest('tr');
                modalProfileShow(tr.attr('id'));
            });
            //when click on btn remove
            $('tbody tr td:last-child button').on('click', function () {
                var tr = $(this).closest('tr');
                remove(tr.attr('id'));
            });

            $('input').attr("autocomplete", "sdafsf");

            $('#profile_btn').on('click', function () {
                modalProfileShow(sessionUser.userId);
            });
        }

        function remove(id) {
            $.post(URL_POST,{id: id, action: "remove"},function (data) {
                $("#" + id).remove();
            });
        }

    </script>


</head>
<body>
<div class="container">
    <div class="row-cols-1">

        <%--navigation menu--%>
        <div id="navi" class="col">
            <ul class="nav">
                <li class="nav-item">
                    <button type="button" class="btn btn-link nav-link"
                            data-toggle="modal"
                            data-target="#addModal">Add user
                    </button>
                </li>
                <li class="nav-item">
                    <button id="profile_btn" type="button" class="btn btn-link nav-link">
                        Your profile
                    </button>
                </li>
                <li class="nav-item ">
                    <button id="signout_btn" type="button" class="btn btn-link nav-link">
                        Sign out
                    </button>
                </li>
                <li class="nav-item ">
                    <button id="info_btn" type="button" class="btn btn-link nav-link">
                        Help
                    </button>
                </li>
            </ul>
        </div>

        <%--table users--%>
        <div class="col mt-4">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th scope="col">Photo</th>
                    <th scope="col">Login</th>
                    <th scope="col">Email</th>
                    <th scope="col">Role</th>
                    <th scope="col">Operations</th>

                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
</div>
<%--modals--%>
<%@include file="includes/modal-profile-edit.jsp" %>
<%@include file="includes/modal-add.jsp" %>
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
        integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
        crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/bs-custom-file-input/dist/bs-custom-file-input.js"></script>


<script>
    //initOperations for upload file
    bsCustomFileInput.init()
</script>
</body>
</html>