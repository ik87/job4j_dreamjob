<script>
    //put data
    function loadProfile(data) {
        $("#login").html(data.login);
        $("#email").html(data.email);
        $("#role").html(data.role);
        $("#country").html(data.country);
        $("#created").html(data.created);
        $("#city").html(data.city);
        $("#img").attr('src', 'data:image/jpeg;base64,' + data.photo);
    }
</script>

<div class="container-sm">
<!--row 1-->
<div class="row  m-3">
    <!--photo image-->
    <div class="col-12 col-lg-4 mt-3">
        <!--row 2-->
        <!--img-->
        <img class="rounded mx-auto d-block" id="img"
             style="width: 100%" onerror="this.src='js//default-user-img.jpg'"/>

    </div>

    <!--user profile-->
    <div class="col-12 col-lg-8">
        <ul class="list-group list-group-flush my-2">
            <li class="list-group-item">
                <div class="row">
                    <div class="col-3 font-weight-bold">Login:</div>
                    <div id="login" class="col">login</div>
                </div>
            </li>
            <li class="list-group-item">
                <div class="row">
                    <div class="col-3 font-weight-bold">Email:</div>
                    <div id="email" class="col">email</div>
                </div>
            </li>
            <li class="list-group-item">
                <div class="row">
                    <div class="col-3 font-weight-bold">Role:</div>
                    <div id="role" class="col">role</div>
                </div>
            </li>
            <li class="list-group-item">
                <div class="row">
                    <div class="col-3 font-weight-bold">Created:</div>
                    <div id="created" class="col">created</div>
                </div>
            </li>
            <li class="list-group-item">
                <div class="row">
                    <div class="col-3 font-weight-bold">Country:</div>
                    <div id="country" class="col">country</div>
                </div>
            </li>
            <li class="list-group-item">
                <div class="row">
                    <div class="col-3 font-weight-bold">City:</div>
                    <div id="city" class="col">city</div>
                </div>
            </li>
        </ul>
    </div>

</div>
</div>