$("#delete-loans").on("click", function (e) {
  e.preventDefault();
  $("#confirmation-modal").foundation("open");
});

$(".cancel-delete").on("click", function (e) {
  e.preventDefault();
  $("#confirmation-modal").foundation("close");
});

$(".confirm-delete").on("click", function (e) {
  e.preventDefault();
  $("#confirm_delete_form")[0].submit();
});

$("a.pagination_link").on("click", function (e) {
  e.preventDefault();
  $("#current_search_form>.input>input#loan_search_page").val(
    $(this).data("page-number")
  );
  $("#current_search_form")[0].submit();
});

$(document).ready(function () {
  $(".institutions_list").select2();
});
