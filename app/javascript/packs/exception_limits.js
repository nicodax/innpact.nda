$('#limit_exception_model').on('change', function (e) {
	var model = $('#limit_exception_model').val();
	// Reset all selects
	$('#limit_exception_model_id').prop('selectedIndex', 0);
	// Hide all selects
	$('[id$=-select]').addClass('hide');
	// Unhide according elements
	$('#' + model + '-select, #form-value, #form-buttons').removeClass('hide');
});

$('[id$=_id_select]').on('change', function (value) {
	$('input#limit_exception_model_id.hidden').val($(this).val());
});
