$(function() {
  console.log('hello?');
  alert('test');
  $("#delete").on("click", function(e) {
    e.preventDefault();
    var confirm = window.confirm("Are you sure you want to delete?");
    if( confirm === true ){
      return true;
    } else {
      return false;
    }
  });
});
