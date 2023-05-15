var selectedLoans = [];

$('#delete-loans').on('click', function (e) {
	e.preventDefault();
	$('#confirmation-modal').foundation('open');
});

$('.cancel-delete').on('click', function (e) {
	e.preventDefault();
	$('#confirmation-modal').foundation('close');
});

$('.confirm-delete').on('click', function (e) {
	e.preventDefault();
	$('#confirm_delete_form').trigger('submit');
});

$(document).ready(function() {
	$('.institutions_list').select2();
});