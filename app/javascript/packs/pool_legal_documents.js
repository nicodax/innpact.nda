var documentUploadField = document.getElementById(
	'pool_legal_document_document'
);

documentUploadField.onchange = function () {
	if (this.files[0].size > 2048 * 1024) {
		alert('Document is too big.');
		this.value = '';
	}
};
