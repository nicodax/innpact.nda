$('#select_all_loans').on('click', function () {
	$('input:checkbox').each((i, el) => {
		!$(el).is(':checked') && $(el).trigger('click');
	});
});

$('#deselect_all_loans').on('click', function () {
	$('input:checkbox').each((i, el) => {
		$(el).is(':checked') && $(el).trigger('click');
	});
});
