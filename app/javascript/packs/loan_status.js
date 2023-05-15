import $ from 'jquery';
import Cleave from 'cleave.js';

// Needed because Cleave.js duplicates input elements
// Cleave.js hotfix
const originalElementFor = (form, query) => {
  const results = form.find(query);
  const ret = results.length > 1 ? results.filter((_idx, el) => el.id) : results;
  return ret;
};

const formattedElementFor = (form, query) => {
  const results = form.find(query);
  if (results.length > 1) {
    const classes = results.map((_idx, el) => el.className).toArray().flat().join();
    const currencyFormat = classes.includes('thousand_currencies_formats');
    const cleaveFormat = classes.includes('cleave_format');
    if (currencyFormat || cleaveFormat) {
      return results.filter((_idx, el) => !el.id);
    }
  }
  return results;
};

// Hedge
const hedgeCb = document.getElementById('loan_loan_version_hedge_checkbox');
const hedgeDiv = document.getElementById('hedge_grid');
const commentDiv = document.getElementById('hedge_comment');

const hiddenHedgeFields = () => {
  hedgeDiv.classList.toggle('hidden', true);
  commentDiv.classList.toggle('hidden', true);
};

const hedgeHidden = (elem) => {
  hedgeDiv.classList.toggle('hidden', !elem.checked);
  commentDiv.classList.toggle('hidden', !elem.checked);
  if (!elem.checked) {
    document.getElementById('loan_loan_version_hedge_spread').value = '';
    document.getElementById('loan_loan_version_hedge_comment').value = '';
    document.getElementById('loan_loan_version_hedge_interest_rate_type_id').value = '';
  }
};

const hedgeCheckCb = () => {
  if (document.getElementById('loan_loan_version_hedge_spread').value !== '' || document.getElementById('loan_loan_version_hedge_comment').value !== '') {
    $('#loan_loan_version_hedge_checkbox').trigger('click');
  }
};

const startHiddenHedgeFields = () => {
  const status = $('.tabs-panel.is-active .nominal_amount_input')[0].dataset.elementPurpose.replace('_nominal_amount_input', '');
  if (['executed', 'invested'].includes(status)) {
    hiddenHedgeFields();
    hedgeCb.addEventListener('change', () => {
      hedgeHidden(hedgeCb);
    });
    hedgeCheckCb();
  }
};

const fillExecutedFields = () => {
  const panel = $('#panel_invested');
  const loanSpreadInput = formattedElementFor(panel, '.loan_spread_input')[0];
  const hedgeSpreadInput = formattedElementFor(panel, '.hedge_spread_input')[0];
  const executedSpreadInput = formattedElementFor(panel, '.executed_spread_input')[0];

  const loanInterestInput = $('.loan_interest_rate_type_input option:selected').text();
  const hedgeInterestInput = $('.hedge_interest_rate_type_input option:selected').text();
  const executedInterestInput = document.getElementById('loan_loan_version_executed_interest_rate_type_executed_interest_rate_type');

  if (hedgeSpreadInput.value !== '' && hedgeInterestInput !== '' && hedgeCb.checked === true) {
    executedSpreadInput.value = hedgeSpreadInput.value;
  } else {
    executedSpreadInput.value = loanSpreadInput.value;
  }

  if (hedgeInterestInput !== '' && hedgeSpreadInput.value !== '' && hedgeCb.checked === true) {
    executedInterestInput.value = hedgeInterestInput;
  } else {
    executedInterestInput.value = loanInterestInput;
  }
};

const addListenerExecutedSpreadFields = () => {
  const panel = $('#panel_invested');
  const loanSpreadInput = formattedElementFor(panel, '.loan_spread_input')[0];
  const hedgeSpreadInput = formattedElementFor(panel, '.hedge_spread_input')[0];
  [loanSpreadInput, hedgeSpreadInput].forEach((el) => {
    el.addEventListener('change', () => {
      fillExecutedFields();
    });
  });
};

const addListenerExecutedInterestFields = () => {
  const loanInterestInput = document.getElementById('loan_loan_version_loan_interest_rate_type_id');
  const hedgeInterestInput = document.getElementById('loan_loan_version_hedge_interest_rate_type_id');
  [loanInterestInput, hedgeInterestInput].forEach((el) => {
    el.addEventListener('change', () => {
      fillExecutedFields();
    });
  });
};

const addListenedHedgeCheckbox = () => {
  document.getElementById('loan_loan_version_hedge_checkbox').addEventListener('click', () => {
    fillExecutedFields();
  });
};

const initHedgeFields = () => {
  if (hedgeCb) {
    startHiddenHedgeFields();
    fillExecutedFields();
    addListenerExecutedSpreadFields();
    addListenerExecutedInterestFields();
    addListenedHedgeCheckbox();
  }
};

// Status Panel
let fundId;
const hideAllNextStatusPanels = () => {
  $('.next_status').addClass('hide');
};

const hidePanels = () => {
  $('.tabs-title').removeClass('is-active');
  $('.tabs-panel').removeClass('is-active');
};

const showStatusPanel = (status) => {
  $(`#tab_title_${status}`).removeClass('hide');
  $(`#panel_${status}`).removeClass('hide');

  $(`#tab_title_${status}`).addClass('is-active');
  $(`#panel_${status}`).addClass('is-active');

  if (status === 'invested') {
    hiddenHedgeFields();
    hedgeCb.addEventListener('change', () => {
      hedgeHidden(hedgeCb);
    });
    hedgeCheckCb();
  }
};

const showLastValidStatusPanel = () => {
  $('.last_valid_status').addClass('is-active');
};

const emptyNextStatusPanels = () => {
  $('.tabs-panel.next_status').not('.is-active').find('.status_input').val('');
};

// Formatting
const formatNominalAmountFormatedStringToFloat = (input) => (parseFloat(input.toString().replace(/,/g, '')));

const updateUsdValues = (value, scope) => {
  if (!Number.isNaN(value) && value !== undefined) {
    const usdAmountInput = $(`[name="loan[loan_version][${scope}_nominal_amount_usd]"]`);
    const currencyShortName = $(
      '#loan_loan_version_currency_id option:selected',
    ).text();
    let currencyRate;
    const currencyRates = JSON.parse(sessionStorage.getItem('currencyRates'));
    if (currencyShortName === 'USD') {
      currencyRate = 1;
    } else if (currencyRates === undefined || currencyRates === null) {
      currencyRate = '';
    } else {
      currencyRate = currencyRates[currencyShortName];
    }

    if (value === '') {
      usdAmountInput.val('');
    } else if (currencyRate === '' || currencyRate === undefined) {
      usdAmountInput.addClass('cta_warning');
      usdAmountInput.val('Missing Exchange Rate');
    } else {
      usdAmountInput.removeClass('cta_warning');
      const regexAddThousandCommaSeparator = /\B(?=(\d{3})+(?!\d))/g;
      usdAmountInput.val(
        (value / currencyRate).toFixed(2).toString().replace(regexAddThousandCommaSeparator, ','),
      );
    }
  }
};

const updateNominalAmountFormatCleaves = () => {
  // eslint-disable-next-line no-restricted-syntax
  for (const field of $('.thousand_currencies_formats_nominal_amount').toArray()) {
    new Cleave(field, { // eslint-disable-line no-new
      numeral: true,
      numeralThousandsGroupStyle: 'thousand',
      swapHiddenInput: true,
      onValueChanged(ev) {
        const status = field.dataset.elementPurpose.replace('_nominal_amount_input', '');
        updateUsdValues(ev.target.rawValue, status);
      },
    });
  }
};

// Trigger
const triggerInputChangeWithData = (form, query, value) => {
  formattedElementFor(form, query).val(value).each((_idx, el) => {
    el.dispatchEvent(new Event('input')); // NOTE: For some reason JQuery trigger doesn't work on this case
  });
};

// Fill Form
const fillStatusInputs = (panel, data) => {
  triggerInputChangeWithData(panel, '.nominal_amount_usd_input', data.nominal_amount_usd);
  triggerInputChangeWithData(panel, '.nominal_amount_input', data.nominal_amount);
  triggerInputChangeWithData(panel, '.tenor_input', data.tenor);
  triggerInputChangeWithData(panel, '.spread_input', data.spread);
  triggerInputChangeWithData(panel, '.upfront_fees_input', data.upfront_fees);
  triggerInputChangeWithData(panel, '.fixed_rate_input', data.fixed_rate);
  triggerInputChangeWithData(panel, '.status_date_input', data.disbursment_date || data.status_date);
  triggerInputChangeWithData(panel, '.deadline_status_date_input', data.maturity_date || data.deadline_status_date);
  if (panel[0].id === 'panel_invested') {
    triggerInputChangeWithData(panel, '.bond_input', data.bond);
    triggerInputChangeWithData(panel, '.nav_usd_input', data.nav_usd);
    triggerInputChangeWithData(panel, '.interest_rate_type_input', data.interest_rate_type);
    triggerInputChangeWithData(panel, '.net_position_value_as_of_today_input', data.net_position_value_as_of_today);
    triggerInputChangeWithData(panel, '.gross_position_value_as_of_today_input', data.gross_position_value_as_of_today);
    triggerInputChangeWithData(panel, '.status_date_input', '');
    triggerInputChangeWithData(panel, '.deadline_status_date_input', '');
    triggerInputChangeWithData(panel, '.invested_hedge_input', data.invested_hedge);
  }
  triggerInputChangeWithData(panel, '.status_comment', data.status_comment);
};

const fillInputsWithFile = (status) => {
  const fd = new FormData();
  const { files } = $(`#${status}_status_data_import_file`)[0];
  const panel = $(`#panel_${status}`);

  if (files.length > 0) {
    fd.append('mode', 'status');
    fd.append('fund_id', fundId);
    fd.append('file', files[0]);
    $.ajax({
      type: 'POST',
      url: '/api/loan_values_imports',
      data: fd,
      contentType: false,
      processData: false,
      success(data) {
        fillStatusInputs(panel, data.data_to_import);
      },
      error() {
        throw new Error('Error importing file');
      },
    });
  }
};

const copyInputsFromLastValidStatus = (status) => {
  const lastValidPanel = $('.tabs-panel.last_valid_status');
  const data = {
    nominal_amount_usd: originalElementFor(lastValidPanel, '.nominal_amount_usd_input').val(),
    nominal_amount: formatNominalAmountFormatedStringToFloat(
      originalElementFor(lastValidPanel, '.nominal_amount_input').val().toString(),
    ),
    tenor: originalElementFor(lastValidPanel, '.tenor_input').val(),
    spread: originalElementFor(lastValidPanel, '.spread_input').val(),
    upfront_fees: originalElementFor(lastValidPanel, '.upfront_fees_input').val(),
    fixed_rate: originalElementFor(lastValidPanel, '.fixed_rate_input').val(),
    status_date: originalElementFor(lastValidPanel, '.status_date_input').val(),
    bond: originalElementFor(lastValidPanel, '.bond_input').val(),
    interest_rate_type: originalElementFor(lastValidPanel, '.interest_rate_type_input').val(),
    deadline_status_date: originalElementFor(lastValidPanel, '.deadline_status_date_input').val(),
  };
  if (hedgeCb !== null && hedgeCb.checked) {
    delete data.spread;
    delete data.interest_rate_type;
  }

  const panel = $(`#panel_${status}`);
  fillStatusInputs(panel, data);
  updateUsdValues(
    formatNominalAmountFormatedStringToFloat(
      data.nominal_amount.toString(),
    ), status,
  );
  updateNominalAmountFormatCleaves();
};

// Event Handlers
$('#loan_loan_version_status').on('change', (event) => {
  const status = event.target.value;

  hideAllNextStatusPanels();

  if ($(`#tab_title_${status}`).length) {
    hidePanels();
    showStatusPanel(status);
  } else {
    showLastValidStatusPanel();
  }
  emptyNextStatusPanels();
});

$('.import_status_data_button').on('click', (e) => {
  e.preventDefault();
  const status = e.target.id.replace('_status_import_data_button', '');
  fillInputsWithFile(status);
  $('.nominal_amount_input').each((_idx, el) => {
    updateUsdValues(
      formatNominalAmountFormatedStringToFloat(
        $(el).val().toString(),
      ), status,
    );
  });
});

$('.copy_status_data_button').on('click', (e) => {
  e.preventDefault();
  const status = e.target.id.replace('_status_copy_data_button', '');
  copyInputsFromLastValidStatus(status);
});

$('#loan_loan_version_currency_id').on('change', () => {
  $('.nominal_amount_input').each((_idx, el) => {
    const status = el.dataset.elementPurpose.replace('_nominal_amount_input', '');
    updateUsdValues(
      formatNominalAmountFormatedStringToFloat(
        $(el).val().toString(),
      ), status,
    );
  });
});

$('[data-name-id="file_import_button"]').on('change', (e) => {
  // eslint-disable-next-line no-unused-expressions
  e.preventDefault;
  $('[data-name-id="file_submit_button"]').trigger('click');
});

$('.nominal_amount_input').on('change', (e) => {
  const status = e.target.dataset.elementPurpose.replace('_nominal_amount_input', '');
  updateUsdValues(e.target.rawValue, status);
});

$(document).ready((_event) => {
  // AJAX Call for currency update
  fundId = $("form[data-element-purpose='loan_form']").data('fund-id');

  $.ajax({
    type: 'GET',
    url: `/api/currency_rates?fund_id=${fundId}`,
    success(data) {
      sessionStorage.setItem('currencyRates', JSON.stringify(data.currency_rates));
      $('.nominal_amount_input').each((_idx, el) => {
        const status = el.dataset.elementPurpose.replace('_nominal_amount_input', '');
        updateUsdValues(
          formatNominalAmountFormatedStringToFloat(
            $(el).val().toString(),
          ), status,
        );
      });
    },
    error() {
    },
  });

  updateNominalAmountFormatCleaves();
  initHedgeFields();

  const currentStatusCheckbox = document.querySelector('.current_status #loan_loan_version_presentable');
  const nextStatusCheckbox = document.querySelector('.next_status #loan_loan_version_presentable');

  const readyToBePresentedCheckbox = currentStatusCheckbox || nextStatusCheckbox;
  const complianceFields = document.getElementById('presentation_compliance_check');
  const sdgFields = document.getElementById('sdg_goals');
  if (readyToBePresentedCheckbox) {
    complianceFields.toggleAttribute('hidden', !readyToBePresentedCheckbox?.checked);
    sdgFields.toggleAttribute('hidden', !readyToBePresentedCheckbox?.checked);
    readyToBePresentedCheckbox?.addEventListener('change', (event) => {
      complianceFields.toggleAttribute('hidden', !event.currentTarget.checked);
      sdgFields.toggleAttribute('hidden', !event.currentTarget.checked);
    });
  }
});
