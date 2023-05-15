$('#delete-fund').on('click', function (e) {
	e.preventDefault();
	$('#confirmation-modal').foundation('open');
});

$('#cancel-delete').on('click', function (e) {
	e.preventDefault();
	$('#confirmation-modal').foundation('close');
});

$('#create_loan_button').on('click', function (e) {
	e.preventDefault();
	var institution_id = $('#loan_institution').val();
	var fund_id = $(this).data('fund-id');
	window.location.href = `/funds/${fund_id}/loans/new?institution_id=${institution_id}`;
});

$('input.input_cta_user').on('change', function (e) {
	$(e.target.parentElement).toggleClass('cta_user_active');
});


$(document).ready(function() {
	$('.institutions_list').select2();
});