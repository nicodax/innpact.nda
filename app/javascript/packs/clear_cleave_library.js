const remove_format_cleaves = () => {
    // eslint-disable-next-line no-restricted-syntax
    for (const field of $('.thousand_currencies_formats').toArray()) {
        // eslint-disable-next-line no-new
        const attribute = field.getAttribute("id");
        if(attribute === '') {
            field.remove();
        } else {
            field.setAttribute('type', 'text');
        }
    }
};

remove_format_cleaves();