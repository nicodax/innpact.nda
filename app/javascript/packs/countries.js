$('.btn_import_countries').on('change', function (e) {
	e.preventDefault();
	$('.cta_submit_countries').trigger('click');
});
