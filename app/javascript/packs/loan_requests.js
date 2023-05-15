$('#delete-loan_request').on('click', function (e) {
	e.preventDefault();
	$('#confirmation-modal').foundation('open');
});

$('#cancel-delete').on('click', function (e) {
	e.preventDefault();
	$('#confirmation-modal').foundation('close');
});
