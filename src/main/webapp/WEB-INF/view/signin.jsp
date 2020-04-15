<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">



    <%--JS--%>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

    <!-- Custom styles for this template -->
    <link href="css/signin.css" rel="stylesheet">


    <style>
        .bd-placeholder-img {
            font-size: 1.125rem;
            text-anchor: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }

    </style>
    <script>
        var toggleShow = true;
        <%--for testing --%>
        $(function () {

            $('[data-toggle="collapse"]').popover({
                placement: 'bottom',
                content: 'Click here. Try my service! ',
            }).popover('show').hover(function () {
                $(this).popover('hide');

            },function () {
                if(toggleShow) {
                    $(this).popover('show');
                }
            });

            $('#demo').on('show.bs.collapse', function (event) {
                toggleShow = false;
                    $('[data-toggle="collapse"]').popover('dispose');
            })
        });
        //generation new user & admin
        function signAs(role) {
            var user = {
                login: "User_" + parseInt(Date.now() / 1000, 10),
                email: "user@gmail.com",
                password: "123",
                country: "Russia",
                city: "Moscow",
                role_id: role,
                action: "add"
            };
            console.log(user);
            $.post("tester", user).done(function (data) {
                $('#login').val(user.login);
                $('#pass').val(user.password);
                signin();
                console.log(data);
            }).fail(function (data) {
                console.log(data);
            })
        }
        <%--end for testing --%>


        function signin() {
            var fields = validate();
            if (fields != '') {
                alert("You have to fill fields: " + fields);
            } else {
                credential();
            }
            return false;
        }



        function validate() {
            var login = $('#login').val();
            var pass = $('#pass').val();

            var fields = '';

            if (login == '') {
                fields += '[login]'
            }

            if (pass == '') {
                fields += '[Password]';
            }

            return fields;
        }

        function credential() {
            var login = $('#login').val();
            var pass = $('#pass').val();
            var status;
            $.ajax({
                type: 'POST',
                url: "login",
                data: {login: login, password: pass},
                dataType: 'text'
            }).done(function (data) {
                location.reload();
            }).fail(function (err) {
                $('body').prepend(
                    "<div class='fixed-top alert alert-danger ' role='alert'>" +
                    "Login or password is not correct" +
                    "</div>"
                );
            });
        }

    </script>

    <title>service entrance</title>
</head>
<body class="text-center">
<div class="container">
<form class="form-signin">
    <h1 class="h3 mb-3 font-weight-normal">Please login</h1>
    <label for="inputLogin" class="sr-only">Login</label>
    <input id="login" class="form-control" type="text" id="inputLogin" placeholder="login" name="login" required autofocus>
    <label for="inputPassword" class="sr-only">Password</label>
    <input id="pass" class="form-control" type="password" id="inputPassword" placeholder="password" name="password" required>
    <button class="btn btn-lg btn-primary btn-block" onclick="return signin()">Sign in</button>


</form>
    <%--for testing --%>
<div class="form-signin">

    <button class="btn btn btn-outline-info btn-block" data-toggle="collapse" data-target="#demo">For Testing</button>

    <div id="demo" class="collapse mt-2 p-2 border border-info rounded ">
        <button class="btn  btn-warning btn-block" onclick="return signAs('1')">Sign in as ADMIN</button>
        <button class="btn  btn-warning btn-block" onclick="return signAs('2')">Sign in as USER</button>
    </div>
</div>
    <%-- end for testing --%>
</div>
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
        integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
        crossorigin="anonymous"></script>
</body>
</html>
