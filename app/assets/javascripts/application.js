function setPoolTargetField () {
    const usd_field = $(".optional[data-target='usd']").parent();
    const percent_field = $(".optional[data-target='percent']").parent();
    const setTargetField = () => {
        let selectedTargetValue = $(".target_unit_select option:selected").val();
        if(selectedTargetValue === 'USD' ){
            usd_field.show();
            percent_field.hide();
        } else {
            usd_field.hide();
            percent_field.show();
        }
    }

    $('.target_unit_select').change( () => {
        setTargetField();
    })

    setTargetField();
}