// Part from the shared/_form view
$('#pool_required_specific_reporting').is(':checked') &&
	$('#specific_reporting').removeClass('hidden');
$('#pool_has_maturity_date').is(':checked') &&
	$('#maturity_date').removeClass('hidden');

var documentUploadField = document.getElementById(
	'pool_pool_documents_attributes_0_document'
);

documentUploadField.onchange = function () {
	if (this.files[0].size > 2048 * 1024) {
		alert('Document is too big.');
		this.value = '';
	}
};

// Part from the index view
(function () {
	$(document).ready(function (event) {
		$('#pool_is_targeted').is(':checked') &&
			$('#restriction_select').removeClass('hidden');
		$('#pool_required_specific_reporting').is(':checked') &&
			$('#specific_reporting').removeClass('hidden');
		$('#pool_has_maturity_date').is(':checked') &&
			$('#maturity_date').removeClass('hidden');
		setPoolTargetField();
	});
})();

var legalUploadField = document.getElementById(
	'pool_pool_legal_documents_attributes_0_document'
);
var documentUploadField = document.getElementById(
	'pool_pool_documents_attributes_0_document'
);

legalUploadField.onchange = function () {
	if (this.files[0].size > 2048 * 1024) {
		alert('Legal document is too big.');
		this.value = '';
	}
};

documentUploadField.onchange = function () {
	if (this.files[0].size > 2048 * 1024) {
		alert('Document is too big.');
		this.value = '';
	}
};
