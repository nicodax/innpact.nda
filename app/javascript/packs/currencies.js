$('.btn_import_currency').on('change', function (e) {
	e.preventDefault();
	$('.cta_submit_currency').trigger('click');
});
