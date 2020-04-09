<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Users list</title>
    <!-- js -->
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script type="text/javascript" src="https://npmcdn.com/parse/dist/parse.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/city.js"></script>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script>
    function remove(id) {
        $.ajax({
            type: 'POST',
            url: "admin",
            data: {id: id, action: "remove"},
            dataType: 'text'
        }).done(function (data) {
               $("#"+id).remove();
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
                    <a class="nav-link active"
                       href="admin/add">Add user</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="admin/profile">Profile</a>
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
                    <th scope="col">#</th>
                    <th scope="col">Photo</th>
                    <th scope="col">Role</th>
                    <th scope="col">Login</th>
                    <th scope="col">Email</th>

                </tr>
                </thead>
                <tbody>
                <c:forEach items="${usersDto}" var="userDto" varStatus="theCount">
                    <tr id="${userDto.userId}" onclick="profile(${userDto.userId})" >
                        <th scope="row">${theCount.index + 1}</th>
                        <td><img style="height: 50px" src="data:image/jpeg;base64,${userDto.photo}"/></td>
                        <td>${userDto.role}</td>
                        <td>${userDto.login}</td>
                        <td>${userDto.email}</td>
                        <td>
<%--                            <a href="admin/profile?id=${userDto.userId}">[profile]</a>
                            <a href="admin/edit?id=${userDto.userId}">[edit]</a>
                            <form action="admin" method="post">
                                <input type="hidden" name="id" value="${userDto.userId}" >
                                <input type="hidden" name="action" value="remove">
                                <input type="submit" value="remove">
                            </form>--%>
                            <button class="btn btn-link" onclick="remove(${userDto.userId})">remove</button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<%--profile--%>
<%@include file="includes/modale-profile.jsp" %>
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