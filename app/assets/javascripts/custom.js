$(document).ready(function() {
    // define maximum length
    var maxLengthOfMicropost = 140;
    // on keyup, change the remaining characters
    $('#micropost_content').keyup(function() {
        var currLength = $(this).val().length;
        var remain = maxLengthOfMicropost - currLength;
        $('#word-count').text(remain);
    })

});