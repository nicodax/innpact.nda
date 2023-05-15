// Prevents more than 2 decimal value
const setDecimalValueToMax = (max, elem) => {
	const value = $(elem).val();
	const decimalValue = value.split('.')[1];
	if (decimalValue && decimalValue.length > max) {
		$(elem).val(value.slice(0, -1));
	}
};

$('#country_gdp').keyup(() => setDecimalValueToMax(2, '#country_gdp'));
$('#country_gdp_per_capita').keyup(() =>
	setDecimalValueToMax(2, '#country_gdp_per_capita')
);
$('#country_gni').keyup(() => setDecimalValueToMax(2, '#country_gni'));
$('#country_gni_per_capita').keyup(() =>
	setDecimalValueToMax(2, '#country_gni_per_capita')
);
