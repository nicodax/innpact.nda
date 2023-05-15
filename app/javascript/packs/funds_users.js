var reader_id_list = [];
var reader_name_list = [];

$('#add_readers').on('click', function () {
	const selected_value = $('#readers').val();
	const selected_text = $('#readers option:selected').html();
	if ((selected_value > 0) & (selected_text != '')) {
		reader_id_list.push(selected_value);
		reader_name_list.push(selected_text);
		var id_list = reader_id_list;
		var last_id = id_list[id_list.length - 1];
		var name_list = reader_name_list;
		var last_name = name_list[name_list.length - 1];

		$('#reader_list').append(
			`<div class="grid-x reader_list_item" data-user-id="user_${last_id}">
      <div class="cell large-10">
      <li>
        <input type='hidden' name='reader[user_ids][]' value='${last_id}'/>${last_name}
      </li>
      </div>
      <div class="cell large-2">
      <a class="reader_buttons remove_reader" delete-data-id=${last_id} data-name="${last_name}" id="remove_reader">&#8722;</a>
      </div>
      </div>`
		);
		if (reader_id_list.includes(selected_value)) {
			$(`#readers option[value='${selected_value}']`).attr(
				'disabled',
				'disabled'
			);
			$(`#reader_user_ids_${selected_value}`).click();
		}
	}
});

$('body').on('click', 'a#remove_reader', function () {
	const delete_id = $(this).attr('delete-data-id');
	const delete_name = $(this).attr('data-name');
	const node = $(`[data-user-id= 'user_${delete_id}']`);
	reader_name_list.pop(delete_name);
	reader_id_list.pop(delete_id);
	$(`#readers option[value='${delete_id}']`).removeAttr('disabled');
	$(`#reader_user_ids_${delete_id}`).click();
	node.remove();
});

$('#reset-reader-form').on('click', function (e) {
	location.reload();
});

$('body').on('click', 'a#remove_reader', function () {
	const id = $(this).attr('delete-data-reader');
	const node = $(`[data-user-id="user_${id}"]`);
	node.remove();
});
