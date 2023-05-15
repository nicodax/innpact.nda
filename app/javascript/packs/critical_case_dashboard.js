$(document).ready(function () {
	var hideRows = function hideRows() {
		$('.hidden-row').hide();
		$('.hidden-table').hide();
	};
	hideRows(); // run function to add classes to alternating table rows
	// toggle-able row
	$('.institution_row')
		.not('.hidden-row')
		.on('click', function () {
			$(this).nextUntil('.stop').toggle();
		});
});
