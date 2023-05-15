const fill_status_inputs = (panel, data) => {
	panel.find('.nominal_amount_usd_input').val(data.nominal_amount_usd);
	panel.find('.nominal_amount_input').val(data.nominal_amount);
	panel.find('.tenor_input').val(data.tenor);
	panel.find('.spread_input').val(data.spread);
	panel.find('.upfront_fees_input').val(data.upfront_fees);
	panel.find('.fixed_rate_input').val(data.fixed_rate);
	panel.find('.status_date_input').val(data.status_date);
	panel.find('.deadline_status_date_input').val(data.deadline_status_date);
};

const fill_general_inputs = (data) => {
	$('#loan_loan_version_currency_id').val(data.currency_id);
	$('#loan_loan_version_loan_type_id').val(data.loan_type_id);
	$('#loan_loan_version_repayment_type_id').val(data.repayment_type_id);
	$('#loan_loan_version_expected_disbursement_date').val(
		data.expected_disbursement_date
	);
	$('#loan_loan_version_probabilities').val(data.probabilities);
	$('#loan_pool_id').val(data.pool_id);
};

$('#initial_loan_import_file').on('change', function (e) {
	const initial_import = $('#initial_loan_import_file');
	e.preventDefault();
	sendFile(initial_import);
});

function sendFile(import_type) {
	var fd = new FormData();
	var files = import_type[0].files;
	var status = import_type.data('status');
	var fund_id = import_type.data('fund-id');
	var panel = $('#panel_' + status);

	if (files.length > 0) {
		fd.append('mode', 'assigned_loan');
		fd.append('fund_id', fund_id);
		fd.append('file', files[0]);
		$.ajax({
			type: 'POST',
			url: '/api/loan_values_imports',
			data: fd,
			contentType: false,
			processData: false,
			success(data) {
				fill_general_inputs(data.data_to_import);
				fill_status_inputs(panel, data.data_to_import);
			},
			error(data) {},
		});
	}
}
