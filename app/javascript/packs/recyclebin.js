$('#destroy-single-item[data-action-id]').on('click', function (e) {
	var selector = $(this).attr('data-selector');
	var checkbox = $('input:checkbox[data-selector=' + selector + ']');
	if (selector === checkbox.attr('data-selector')) {
		checkbox.trigger('click');
	}

	e.preventDefault();
	$('.result-messages').empty();
	$('#destroy-confirmation-modal').foundation('open');
});

$('#restore-single-item[data-action-id]').on('click', function (e) {
	var selector = $(this).attr('data-selector');
	var checkbox = $('input:checkbox[data-selector=' + selector + ']');
	if (selector === checkbox.attr('data-selector')) {
		checkbox.trigger('click');
	}

	e.preventDefault();
	$('.result-messages').empty();
	$('#restore-confirmation-modal').foundation('open');
});

$('#cancel-destroy').on('click', function (e) {
	e.preventDefault();
	$('#destroy-confirmation-modal').foundation('close');
});

$('#cancel-restore').on('click', function (e) {
	e.preventDefault();
	$('#restore-confirmation-modal').foundation('close');
});

$('#select_all_items').on('click', function () {
	$('input:checkbox').each((i, el) => {
		!$(el).is(':checked') && $(el).trigger('click');
	});
});

$('#deselect_all_items').on('click', function () {
	$('input:checkbox').each((i, el) => {
		$(el).is(':checked') && $(el).trigger('click');
	});
});
