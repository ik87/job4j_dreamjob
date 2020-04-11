
function checkEmail(email) {
    var re = /\S+@\S+\.\S+/;
    return !re.test(email.val());
}

function check(field, check) {
    var correct = true;
    if (check(field)) {
        correct = false;
        field.removeClass("is-valid").addClass("is-invalid");
    } else {
        field.removeClass("is-invalid").addClass("is-valid");
    }
    return correct;
}

function checkLength(el) {
    return el.val().length < 3;
}

function checkPass(id_passA, id_passB, id_displayPassB) {
    $('#' + id_passA).on("keyup", function () {
        if ($(this).val().length > 2) {
            $(this).removeClass("is-invalid").addClass("is-valid");
            $('#' + id_displayPassB).removeClass("d-none");
        }
        if ($(this).val().length < 2) {
            $(this).removeClass("is-valid").addClass("is-invalid");
            $('#' + id_passB).val('');
            $('#' + id_displayPassB).addClass("d-none");
        }
    });

    $('#' + id_passB).on("keyup", function () {
        if ($(this).val() == $('#' + id_passA).val()) {
            $(this).removeClass("is-invalid").addClass("is-valid");
        } else {
            $(this).removeClass("is-valid").addClass("is-invalid");
        }
    });
}