$(document).ready(function() {
    $('.institutions_list').select2({
        placeholder: 'Select an institution'
    });
});

$('.institutions_list').on('select2:select', function (e) {
    let data = e.params.data;
    window.location.pathname = `${data["id"]}`
});