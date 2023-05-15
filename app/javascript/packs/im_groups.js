var im_id_list = [];
var im_name_list = [];

$('#add_im').on('click', function () {
	const selected_value = $('#investment_managers').val();
	const selected_text = $('#investment_managers option:selected').html();
	if ((selected_value > 0) & (selected_text != '')) {
		im_id_list.push(selected_value);
		im_name_list.push(selected_text);
		var id_list = im_id_list;
		var last_id = id_list[id_list.length - 1];
		var name_list = im_name_list;
		var last_name = name_list[name_list.length - 1];

		$('#im_list').append(
			`<div class="grid-x im_list_item" id="user_${last_id}">
      <div class="cell large-10">
      <li>
        <input type='hidden' name='im_group[user_ids][]' value='${last_id}'/>${last_name}
      </li>
      </div>
      <div class="cell large-2">
      <a class="im_buttons remove_im" data-id=${last_id} data-name="${last_name}" id="remove_im">&#8722;</a>
      </div>
      </div>`
		);
		if (im_id_list.includes(selected_value)) {
			$(`#investment_managers option[value='${selected_value}']`).attr(
				'disabled',
				'disabled'
			);
			$(`#im_group_user_ids_${selected_value}`).click();
		}
	}
});

$('body').on('click', 'a#remove_im', function () {
	const delete_id = $(this).attr('data-id');
	const delete_name = $(this).attr('data-name');
	const node = $(`#user_${delete_id}`);
	im_name_list.pop(delete_name);
	im_id_list.pop(delete_id);
	$(`#investment_managers option[value='${delete_id}']`).removeAttr('disabled');
	$(`#im_group_user_ids_${delete_id}`).click();
	node.remove();
});

$('#reset-im-form').on('click', function (e) {
	location.reload();
});

$('body').on('click', 'a#remove_im', function () {
	const id = $(this).attr('delete-data-id');
	const node = $(`[data-user-id="user_${id}"]`);
	node.remove();
});
