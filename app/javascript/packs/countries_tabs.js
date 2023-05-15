const filterItemsClass = ".countries";
const searchField = "#countries_search_field"

const searchInRestriction = () => {
  const field_value = $(searchField).val()?.toUpperCase();
  const tab_list = $('a[aria-selected="true"]');
  const category_id = $(tab_list).prop("hash");

  $(filterItemsClass, category_id).each( (i, item) => {
    const value = $(item).text();
    const uppercase_value = value.toUpperCase();
    const display = uppercase_value.includes(field_value) ? 'block' : 'none'

    $(item).css("display", display)
  })
}

const resetSearchField = () => {
  $(searchField).val('');

  $(filterItemsClass).each( (i, item) => {
    $(item).css("display", 'block')
  })
}

$('#countries-tabs').on("click", () => resetSearchField())
$(searchField).on('keyup', () => searchInRestriction())
