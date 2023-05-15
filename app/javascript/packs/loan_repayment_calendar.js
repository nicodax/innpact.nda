/* eslint-disable no-undef */
/* eslint-disable camelcase */
import Cleave from 'cleave.js';

const remove_format_cleaves = () => {
  // eslint-disable-next-line no-restricted-syntax
  for (const field of $('.thousand_currencies_formats_repayment_date').toArray()) {
    // eslint-disable-next-line no-new
    const attribute = field.getAttribute("id");
    if(attribute === '') {
      field.remove();
    } else {
      field.setAttribute('type', 'text');
    }
  }
};

const update_repayment_calendar_format_cleaves = () => {
  // eslint-disable-next-line no-restricted-syntax
  for (const field of $('.thousand_currencies_formats_repayment_date').toArray()) {
    // eslint-disable-next-line no-new
    new Cleave(field, {
      numeral: true,
      numeralThousandsGroupStyle: 'thousand',
      swapHiddenInput: true,
    });
  }
};

remove_format_cleaves();
update_repayment_calendar_format_cleaves();
