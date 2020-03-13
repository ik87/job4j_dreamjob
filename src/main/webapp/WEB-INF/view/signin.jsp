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

    <!-- Custom styles for this template -->
    <link href="css/signin.css" rel="stylesheet">


    <%--JS--%>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

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

<form class="form-signin" method="post">
    <h1 class="h3 mb-3 font-weight-normal">Please login</h1>
    <label for="inputLogin" class="sr-only">Login</label>
    <input id="login" class="form-control" type="text" id="inputLogin" placeholder="login" name="login" required
           autofocus>
    <label for="inputPassword" class="sr-only">Password</label>
    <input id="pass" class="form-control" type="password" id="inputPassword" placeholder="password" name="password"
           required>
    <button class="btn btn-lg btn-secondary btn-block btn-primary" onclick="return signin()">Sign in
    </button>
    <button class="btn btn-lg btn-secondary btn-block" href="signup">Sign up</button>
</form>
</body>
</html>
