// Try inline comment editing
var comments = document.getElementsByClassName('comment');

function show(comment) {
    for (var i = 0; i < comments.length; i++) {
        comments[i].style.display = 'none';
    }
    document.getElementById("edit_comment_" + comment).style.display = 'inline-block';
}
function hide(comment) {
    document.getElementById("edit_comment_" + comment).style.display = 'none';
}
