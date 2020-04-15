<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>User profile</title>


    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <%--JS--%>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" src="js/credential.js"></script>
    <script type="text/javascript" src="js/bing_map.js"></script>
    <script type='text/javascript' src='https://www.bing.com/api/maps/mapcontrol?callback=GetMap' async defer></script>

    <script>
        const URL_UPLOAD_IMG = "user/upload";
        const URL_POST = "user";
        const URL_GET = "user";
        const URL_SIGNOUT = "signout";

        $(function () {
            //load data
            $.get(URL_GET, loadProfile);

            //signout
            $('#signout_btn').on('click', function () {
                $.get(URL_SIGNOUT,function () {
                    location.reload();
                });
            })
        });

    </script>

</head>
<body>
<div class="container-sm">
    <div class="row">
        <!--navigation-->
        <div class="col-12">
            <ul class="nav">

                <li class="nav-item">
                    <button type="button" class="btn btn-link nav-link" data-toggle="modal" data-target="#editModal" >Edit</button>
                </li>
                <li class="nav-item">
                    <button id="signout_btn" type="button" class="btn btn-link nav-link" >Sign out</button>
                </li>

            </ul>
            <hr>
        </div>
    <%@include file="includes/info.jsp" %>
</div>
<!-- edit profile modal-->
<%@include file="includes/modal-edit.jsp" %>

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