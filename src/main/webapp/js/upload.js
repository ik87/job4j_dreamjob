IMG = function () {
    this.upload = function (file, id, url) {
        var data = new FormData();
        data.append('file', file);
        data.append('id', id);

        if (typeof file !== 'undefined') {
            $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                url: url + "/upload",
                data: data,
                processData: false,
                contentType: false,
            }).done(function (data) {
                $('#img').attr('src', 'data:image/jpeg;base64,' + data);
            });
        }
    }
}