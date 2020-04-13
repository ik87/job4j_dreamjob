<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Users list</title>
    <!-- js -->
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script type="text/javascript" src="https://npmcdn.com/parse/dist/parse.min.js"></script>
    <script src="js/credential.js"></script>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <script>
        let URL_UPLOAD_IMG = "admin/upload";
        let URL_POST = "admin";
        let URL_GET_USER_ID = "admin?id=";
        let URL_GET_USER = "admin";

        $(function () {
            $('tbody tr td:not(:last-child)').on('click',function () {
                var tr = $(this).closest('tr');
                modalProfileShows(tr.attr('id'));
            });

            $('#profile_btn').on('click', function () {
                modalProfileShows(undefined);
            });

            $('tbody tr td:last-child button').on('click', function () {
                var tr = $(this).closest('tr');
                remove(tr.attr('id'));
            });


        });

        function remove(id) {
            $.ajax({
                type: 'POST',
                url: URL_POST,
                data: {id: id, action: "remove"},
                dataType: 'text'
            }).done(function (data) {
                $("#" + id).remove();
            });
        }


    </script>


</head>
<body>
<div class="container">
    <div class="row-cols-1">

        <%--navigation menu--%>
        <div class="col">
            <ul class="nav">
                <li class="nav-item">
                    <button type="button" class="btn btn-link nav-link"
                            data-toggle="modal"
                            data-target="#addModal">Add user
                    </button>
                </li>
                <li class="nav-item">
                    <button id="profile_btn" type="button" class="btn btn-link nav-link">
                        Profile
                    </button>
                </li>
                <li class="nav-item ">
                    <a class="nav-link" href="signout">Sign out</a>
                </li>
            </ul>
        </div>

        <%--table users--%>
        <div class="col mt-4">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th scope="col">Photo</th>
                    <th scope="col">Role</th>
                    <th scope="col">Login</th>
                    <th scope="col">Email</th>
                    <th scope="col">Operations</th>

                </tr>
                </thead>
                <tbody>
                <c:forEach items="${usersDto}" var="userDto">
                    <c:if test="${userDto.userId != sessionScope.user.id}">
                        <tr id="${userDto.userId}">
                            <td ><img style="height: 50px" src="data:image/jpeg;base64,${userDto.photo}"
                                     onerror="this.src='js//default-user-img.jpg'"/></td>
                            <td>${userDto.role}</td>
                            <td>${userDto.login}</td>
                            <td>${userDto.email}</td>
                            <td>
                                <button class="btn btn-link" >remove</button>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<%--modals--%>
<%@include file="includes/modale-profile.jsp" %>
<%@include file="includes/modale-add.jsp" %>
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
        integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
        crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/bs-custom-file-input/dist/bs-custom-file-input.js"></script>
<script type="text/javascript" src="js/bing_map.js"></script>
<script>
    entityBingMap.searchBoxContainer = "#e_searchBoxContainer";
    entityBingMap.searchBox = "#e_searchBox";
    entityBingMap.selectedSuggestion = function(result) {
        $('#e_city').val(result.address.locality || '');
        $('#e_country').val(result.address.countryRegion || '');
    };
</script>
<script>
    //init for upload file
    bsCustomFileInput.init()
</script>
</body>
</html>