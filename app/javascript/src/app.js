import $ from 'jquery';

window.$ = $;
window.jQuery = $;

import 'foundation-sites';
// import Foundation from 'foundation-sites';
// If you want to pick and choose which modules to include, comment out the above and uncomment
// the line below
import './lib/foundation-explicit-pieces';

$(document).on('turbolinks:load', function () {
	$(document).foundation();

	$('.app-dashboard-body-content').on('scroll', function () {
		$('.tooltip').hide();
	});
	$('.has-tip').on('mouseleave', function () {
		$('.tooltip').hide();
	});

	$('#institution_covenant_upload').on('click', function () {
		$('#institution_covenant_upload').addClass('is-active');
	});

	// $(document)
	//   .foundation()
	//   .trigger('enhance.tablesaw') ;

	// var TablesawConfig = {
	//   swipeHorizontalThreshold: 15
	// };

	$('#new_country').on('change', function (e) {
		// do whatever you need to do when something's changed.
		// perhaps set up an onExit function on the window
	});

	// app dashboard toggle
	$('[data-app-dashboard-toggle-shrink]').on('click', function (e) {
		e.preventDefault();
		$(this)
			.parents('.app-dashboard')
			.toggleClass('shrink-medium')
			.toggleClass('shrink-large');
	});

	// BURGER
	$('.material--burger').on('click', function () {
		$(this).toggleClass('material--arrow');
	});
	$('.navigation--button, .material--burger').click(function () {
		$('.menu').toggleClass('menu_visible');
		return false;
	});
	// END BURGER

	// DASHBOARD FOUNDATION JS
	$('[data-app-dashboard-toggle-shrink]').on('click', function (e) {
		e.preventDefault();
		$(this)
			.parents('.app-dashboard')
			.toggleClass('shrink-medium')
			.toggleClass('shrink-large');
	});

	// DASHBOARD FOUNDATION JS
	$('body').on('click', function (e) {
		if (
			$('.menu_hover').hasClass('display_menu') &&
			!$(e.target).parents('.settings').length
		) {
			$('.menu_hover').removeClass('display_menu');
		}
	});

	$('.settings').on('click', function () {
		$('.menu_hover').toggleClass('display_menu');
	});

	$('#reset-form').on('click', function () {
		$('form').trigger('reset');
	});

	var deletedItems = [];

	$('.select-item').on('click', function (e) {
		var itemId = e.target.dataset.itemId;
		var itemClass = e.target.dataset.itemClass;

		var item = {
			itemClass: itemClass,
			itemId: itemId,
		};

		if (e.target.checked) {
			deletedItems.push({
				itemClass: itemClass,
				itemId: itemId,
			}); // If checked, add to selected ids array
		} else {
			var filteredArray = deletedItems.filter(function (value, index, arr) {
				return value.itemId != item.itemId && value.itemClass == item.itemClass;
			}); // else filter the array to remove it
			deletedItems = filteredArray; // replace the original array with the filtered one
		}
	});

	$('#restore-items, #confirm-restore-items').on('click', function (e) {
		e.preventDefault();
		if (deletedItems.length > 0) {
			var url = 'recycle_bin/restore_items';
			$.ajax({
				url: url,
				method: 'put',
				format: 'json',
				data: {
					deletedItems,
				},
				success: function (user) {
					$('.result-messages').html(
						"<p class='success'>Records restored with success. Reloading page ..</p>"
					);
					setTimeout(function () {
						location.reload();
					}, 3000);
				},
				error: function (response) {
					$('.result-messages').html(
						"<p class='warning'>Couldn't restore records</p>"
					);
				},
			});
		} else {
			$('.result-messages').html("<p class='warning'>No records selected</p>");
		}
	});

	$('#destroy-items, #confirm-destroy-items').on('click', function (e) {
		e.preventDefault();
		if (deletedItems.length > 0) {
			var url = 'recycle_bin/destroy_items';

			$.ajax({
				url: url,
				method: 'delete',
				format: 'json',
				data: {
					deletedItems,
				},
				success: function (user) {
					$('.result-messages').html(
						"<p class='success'>Records deleted with success. Reloading page ..</p>"
					);
					setTimeout(function () {
						location.reload();
					}, 3000);
				},
				error: function (response) {
					$('.result-messages').html(
						"<p class='warning'>Couldn't delete records</p>"
					);
				},
			});
		} else {
			$('.result-messages').html("<p class='warning'>No records selected</p>");
		}
	});
});
