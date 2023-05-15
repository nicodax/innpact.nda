$('#import_covenant_file').on('change', function (e) {
	e.preventDefault();
	$('.cta_submit_covenant').trigger('click');
});

Turbolinks.clearCache();

if (window.location.pathname.includes('settings/covenants')) {
	$('#institution_covenant_upload').addClass('is-active');
}
