import $ from 'jquery';
import Cleave from 'cleave.js';

const activateCleave = () => {
  $('.thousand_currencies_formats').toArray().forEach((field) => {
    new Cleave(field, { // eslint-disable-line no-new
      numeral: true,
      numeralThousandsGroupStyle: 'thousand',
      swapHiddenInput: true,
    });
  });

  const hedgeFormatQuery = '.executed_hedge_fx_rate_format';
  if (document.querySelectorAll(hedgeFormatQuery).length > 0) {
    new Cleave(hedgeFormatQuery, { // eslint-disable-line no-new
      numeral: true,
      numeralThousandsGroupStyle: 'thousand',
      swapHiddenInput: true,
      numeralDecimalScale: 9,
    });
  }

  $('.cleave_format.two_digits_percentage').toArray().forEach((field) => {
    new Cleave(field, { // eslint-disable-line no-new
      numeral: true,
      numeralThousandsGroupStyle: 'thousand',
      swapHiddenInput: true,
      numeralIntegerScale: 3,
      numeralDecimalScale: 4,
    });
  });

  $('.seven_digits_percentage').toArray().forEach((field) => {
    new Cleave(field, { // eslint-disable-line no-new
      numeral: true,
      numeralThousandsGroupStyle: 'thousand',
      swapHiddenInput: true,
      numeralIntegerScale: 3,
      numeralDecimalScale: 7,
    });
  });

  $('.seven_digits_thousands_formats').toArray().forEach((field) => {
    new Cleave(field, { // eslint-disable-line no-new
      numeral: true,
      numeralThousandsGroupStyle: 'thousand',
      swapHiddenInput: true,
      numeralIntegerScale: 10,
      numeralDecimalScale: 7,
    });
  });

  $('.seven_digits_thousands_no_decimal_formats').toArray().forEach((field) => {
    new Cleave(field, { // eslint-disable-line no-new
      numeral: true,
      numeralThousandsGroupStyle: 'thousand',
      swapHiddenInput: true,
      numeralIntegerScale: 10,
      numeralDecimalScale: 0,
    });
  });
};

$(document).ready(() => activateCleave());
