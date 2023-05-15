const get_parent_line = (input) => {
	var input_line = $(input).parents('tr');
	return input_line;
};

const check_input_change = (input) => {
	var input_line = get_parent_line(input);
	var status_input = input_line.find('[data-element-purpose="status_input"]');
	var original_amount_input = input_line.find(
		'[data-element-purpose="original_amount_input"]'
	);
	var received_amount_input = input_line.find(
		'[data-element-purpose="received_amount_input"]'
	);
	if (
		status_input.val() == status_input.data('initial-value') &&
		original_amount_input.val() == original_amount_input.data('initial-value') &&
		received_amount_input.val() == received_amount_input.data('initial-value')
	) {
		input_line.removeClass('modified');
	} else {
		input_line.addClass('modified');
	}
};

const update_status_from_date = (input) => {
	const chosen_date = new Date($(input).val());
	const parent_line = get_parent_line(input);
	const status_input = parent_line.find('[data-element-purpose="status_input"]');
	const current_date = new Date();
	const provision_input = parent_line
		.find('input[data-element-purpose=provision_input], input[data-element-purpose=provision_amount_input]');

	if (chosen_date < current_date) {
		status_input.val('paid');
		provision_input.val(0);
		provision_input.prop('readonly', true);
	} else {
		status_input.val('pending');
		provision_input.prop('readonly', false);
	}
};

$('.repayment_calendar_updatable_input').on('change', function (e) {
	check_input_change(this);
});

$('.repayment_date_input').on('change', function (e) {
	update_status_from_date(this);
});

$('.repayment_calendar_lines_table').on(
	'cocoon:after-insert',
	function (e, insertedItem, originalEvent) {
		$(this)
			.find('.repayment_date_input')
			.on('change', function (e) {
				update_status_from_date(this);
			});
	}
);

const repayment_rows = $('tr[data-element-purpose=repayment_row]');
const add_line_button = $(
	'[data-element-purpose=add_principal_repayment_line_button]'
);

repayment_rows.each(function () {
	attach_event_to_row($(this));
});

add_line_button.on('click', function () {
	setTimeout(function () {
		const row = $('tr[data-element-purpose=repayment_row]').last();
		attach_event_to_row(row);
	}, 0);
});

function attach_event_to_row(row) {
	const status_value = $('select[data-element-purpose=status_input]', row);
	const received_amount_input = $('[data-element-purpose="received_amount_input"]', row);
	const provision_input = $(
		'input[data-element-purpose=provision_input], input[data-element-purpose=provision_amount_input]',
		row
	);

	status_value.on('change', function () {
		set_status_value.call(this, provision_input, received_amount_input);
	});

	if (status_value.val() === 'paid') {
		provision_input.prop('readonly', true);
	}
}

function set_status_value(provision_input, received_amount_input) {
	if ($(this).val() === 'paid') {
		provision_input.val(0);
		provision_input.prop('readonly', true);
	} else {
		provision_input.prop('readonly', false);
		received_amount_input.val(0);
	}
}
