<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>User profile</title>

    <!-- js -->
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script type="text/javascript" src="https://npmcdn.com/parse/dist/parse.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/city.js"></script>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <style>
        .ui-front {
            z-index: 9999;
        }
    </style>

    <script>
        function send() {
            var input = $('#inputGroupFile03')[0];
            var file = input.files[0];
            var id = $('#id').val();
            var data = new FormData();

            data.append('file', file);
            data.append('id', id);

            if (typeof file !== 'undefined') {
                $.ajax({
                    type: "POST",
                    enctype: 'multipart/form-data',
                    url: "${pageContext.request.contextPath}/${sessionScope.user.role.role}/upload",
                    data: data,
                    processData: false,
                    contentType: false,
                    success: function (data) {
                        $('#img').attr('src', 'data:image/jpeg;base64,' + data);
                    }
                });
            }
        }

        function remove() {
            var id = $('#id').val();

            $.ajax({
                type: 'POST',
                url: "${pageContext.request.contextPath}/${sessionScope.user.role.role}",
                data: {id: id, action: "deleteImg"},
                dataType: 'text'
            }).done(function (data) {
                $('#img').attr('src', 'data:image/jpeg;base64,');
            });
        }
    </script>


    <style>
        /*                                div {
                                            border: 1px solid cadetblue !important;
                                        }*/
        .container-sm {
            max-width: 850px;
        }
    </style>
</head>
<body>
<div class="container-sm">
    <!--row 1-->
    <div class="row  m-3">
        <!--navigation-->
        <div class="col-12">
            <ul class="nav">
                <c:if test="${sessionScope.user.role.role eq 'admin'}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/${sessionScope.user.role.role}">Users
                            list</a>
                    </li>
                </c:if>
                <li class="nav-item">
                    <a class="nav-link active"
                       href="${pageContext.request.contextPath}/${sessionScope.user.role.role}/edit?id=${userDto.userId}">Edit
                        profile</a>
                </li>

                <li class="nav-item">
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editModal" >Edit profile M</button>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="#">Remove profile</a>
                </li>
                <li class="nav-item ">
                    <a class="nav-link" href="${pageContext.request.contextPath}/signout">Sign out</a>
                </li>
            </ul>
            <hr>
        </div>
        <!--photo image-->
        <div class="col-sm-5  col-md-4">
            <!--row 2-->

            <!--img-->
            <img class="rounded mx-auto d-block" id="img" style="width: 100%"
                 src="data:image/jpeg;base64,${userDto.photo}"/>

            <!--upload img-->
            <from>
                <input id="id" type='hidden' name='id' value='${userDto.userId}'>
                <div class="form-group row">
                    <div class="col-sm-10">
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
                <button type="button" class="btn btn-primary" onclick="send()">upload</button>
            <!--delete img button-->
                <button type="button" class="btn btn-danger" onclick="remove()">delete</button>
            </div>

        </div>

        <!--user profile-->
        <div class="col-sm-5 col-md-8">
            <ul class="list-group list-group-flush my-2">
                <li class="list-group-item">
                    <div class="row">
                        <div class="col-sm-12 col-md-2 font-weight-bold">Login:</div>
                        <div id="login" class="col">${userDto.login}</div>
                    </div>
                </li>
                <li class="list-group-item">
                    <div class="row">
                        <div class="col-sm-12 col-md-2 font-weight-bold">Email:</div>
                        <div id="email" class="col">${userDto.email}</div>
                    </div>
                </li>
                <li class="list-group-item">
                    <div class="row">
                        <div class="col-sm-12 col-md-2 font-weight-bold">Role:</div>
                        <div id="role" class="col">${userDto.role}</div>
                    </div>
                </li>
                <li class="list-group-item">
                    <div class="row">
                        <div class="col-sm-12 col-md-2 font-weight-bold">Created:</div>
                        <div id="created" class="col">${userDto.created}</div>
                    </div>
                </li>
                <li class="list-group-item">
                    <div class="row">
                        <div class="col-sm-12 col-md-2 font-weight-bold">Country:</div>
                        <div id="country" class="col">${userDto.country}</div>
                    </div>
                </li>
                <li class="list-group-item">
                    <div class="row">
                        <div class="col-sm-12 col-md-2 font-weight-bold">City:</div>
                        <div id="city" class="col">${userDto.city}</div>
                    </div>
                </li>
            </ul>
        </div>

    </div>
</div>
<!-- edit profile modal-->

<%@include file="includes/modale-edit-proflie.jsp" %>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
        integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
        crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/bs-custom-file-input/dist/bs-custom-file-input.js"></script>
<script>
    //init for upload file
    bsCustomFileInput.init()
</script>

</body>
</html>