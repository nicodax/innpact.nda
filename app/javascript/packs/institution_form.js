import $ from 'jquery';
import Cleave from 'cleave.js';

const floatOrZero = (str) => (Number.isNaN(Number.parseFloat(str)) ? 0 : Number.parseFloat(str));

const originalElementFor = (form, query) => {
  const results = Array.from(form.querySelectorAll(query));
  const ret = results.length > 1 ? results.filter((_idx, el) => el.id !== '')[0] : results[0];
  return ret;
};

const formattedElementFor = (form, query) => {
  const results = Array.from(form.querySelectorAll(query));
  if (results.length > 1) {
    const classes = results.map((result) => result.classList.value).join();
    const currencyFormat = classes.includes('thousand_currencies_formats');
    const cleaveFormat = classes.includes('cleave_format');
    if (currencyFormat || cleaveFormat) {
      const filtered = results.filter((_idx, el) => el.id !== '');
      return filtered[0];
    }
  }
  return results;
};

const updateTotal = (targetField, sum) => {
  const el = targetField;
  el.innerText = `${sum} %`;
  el.classList.toggle('warning', sum !== 100 && sum !== 0);
};

const percentageFieldsSetup = (percentageFields, targetField) => {
  updateTotal(targetField, percentageFields.reduce((acc, f) => acc + floatOrZero(f.value), 0.0));
  percentageFields.forEach((field) => {
    field.addEventListener('input', (_ev) => {
      const sum = percentageFields.reduce((acc, f) => acc + floatOrZero(f.value), 0.0);
      updateTotal(targetField, sum);
    });
  });
};

const servicesOfferedSetup = () => {
  const toggleVisibility = (els, val) => {
    els.forEach((el) => {
      el.classList.toggle('hidden', val !== 'true');
      const targetInput = el.querySelector('input');
      if (val === 'true') {
        targetInput?.removeAttribute('disabled');
      } else {
        targetInput?.setAttribute('disabled', 'disabled');
      }
    });
  };
  const mobileBankingClientsEls = Array.from(document.getElementsByClassName('mobile_banking_clients'));
  const depositClientsEls = Array.from(document.getElementsByClassName('deposit_clients'));
  const mobileBankingServices = document.getElementById('positive_impact_services_offered_mobile_banking_services');
  const deposits = document.getElementById('positive_impact_services_offered_deposits');

  toggleVisibility(mobileBankingClientsEls, mobileBankingServices.value);
  mobileBankingServices.addEventListener('input', (ev) => { toggleVisibility(mobileBankingClientsEls, ev.target.value); });
  toggleVisibility(depositClientsEls, deposits.value);
  deposits.addEventListener('input', (ev) => { toggleVisibility(depositClientsEls, ev.target.value); });
};

const institutionGeneralSetup = () => {
  const toggleVisibility = (els, val) => {
    els.forEach((el) => {
      el.classList.toggle('hidden', val !== 'true');
      const targetInput = el.querySelector('input');
      if (val === 'true') {
        targetInput?.removeAttribute('disabled');
      } else {
        targetInput?.setAttribute('disabled', 'disabled');
      }
    });
  };
  const inWatchReasonListEls = Array.from(document.getElementsByClassName('in_watchlist_reason_form'));
  const inWatchListServices = document.getElementById('institution_in_watchlist');

  toggleVisibility(inWatchReasonListEls, inWatchListServices.value);
  inWatchListServices.addEventListener('input', (ev) => { toggleVisibility(inWatchReasonListEls, ev.target.value); });
};

const dynamicUnitsFor = (selectId, valueId, formQuery, valueInputQuery) => {
  const selectEl = document.getElementById(selectId);
  const containerEl = document.getElementById(valueId).parentElement.parentElement;
  const formEl = document.querySelector(formQuery);
  const valueEl = originalElementFor(formEl, valueInputQuery);

  const unitEl = document.createElement('div');
  unitEl.classList.add('input-group-label');

  let valueCleave = null;
  const triggerCleaveJS = (unit) => {
    const unitLabel = unit.selectedOptions[0].dataset.unit;
    unitEl.innerText = unitLabel;
    containerEl.appendChild(unitEl);

    // This basically undo manually the changes made by Cleave.js
    // Unfortunetly was the best solution we could found. It's problematic and brittle,
    // as it depends on implementation details of the library.
    // Also requires code duplication, because of the way the library works.
    const cleaveNodes = document.querySelectorAll(valueInputQuery);
    Array.from(cleaveNodes).forEach((el) => {
      if (el.id === '') {
        el.remove();
      } else {
        el.setAttribute('type', 'text');
      }
    });
    valueCleave?.destroy();
    valueCleave = null;

    switch (unitLabel) {
      case '%':
        // Duplication from cleave_form_format.js but clave can't handle it dynamically
        // See: https://github.com/nosir/cleave.js/issues/138#issuecomment-268024840
        // socialValueEl.classList.add('cleave_format', 'two_digits_percentage');
        valueCleave = new Cleave(valueEl, {
          numeral: true,
          numeralThousandsGroupStyle: 'thousand',
          swapHiddenInput: true,
          numeralIntegerScale: 3,
          numeralDecimalScale: 7,
        });
        break;
      case '#':
        unitEl.innerText = '';
        new Cleave(valueEl, { // eslint-disable-line no-new
          numeral: true,
          numeralThousandGroupStyle: 'thousand',
          swapHiddenInput: true,
          numeralIntegerScale: 10,
          numeralDecimalScale: 0,
        });
        break;
      case 't/million USD':
      case 'm3/million USD':
        new Cleave(valueEl, { // eslint-disable-line no-new
          numeral: true,
          numeralThousandsGroupStyle: 'thousand',
          swapHiddenInput: true,
          numeralIntegerScale: 10,
          numeralDecimalScale: 7,
        });
        break;
      default:
        unitEl.innerText = '';
        break;
    }
  };

  triggerCleaveJS(selectEl);
  selectEl.addEventListener('input', (ev) => {
    triggerCleaveJS(ev.target);
  });
};

const dynamicUnits = () => {
  dynamicUnitsFor(
    'additional_pais_social_social_pai_reported',
    'additional_pais_social_social_pai_value',
    'form.additional_pais_social',
    'input[name="additional_pais_social[social_pai_value]"]',
  );
  dynamicUnitsFor(
    'additional_pais_environment_environment_pai_reported',
    'additional_pais_environment_environment_pai_value',
    'form.additional_pais_environment',
    'input[name="additional_pais_environment[environment_pai_value]"',
  );
};

$(document).ready(() => {
  const breakdownForm = document.querySelector('form.institution_specific_breakdown');
  const servicesOffered = document.querySelector('form.institution_services_offered');
  const generalForm = document.querySelector('form.institution_general');
  const paiForm = document.querySelector('form.institution_esg_pai_indicator');

  if (breakdownForm) {
    const bySectorFields = ['trade_and_services', 'agriculture', 'production', 'consumption', 'by_sector_other']
      .map((field) => (`institution_specific_breakdown[${field}]`));
    const bySectorInputFields = bySectorFields.map((field) => originalElementFor(breakdownForm, `input[name="${field}"]`));
    const bySectorTotalField = document.getElementById('distribution_by_sector_total_sum');

    const byLoanPurposeFields = ['microenterprise', 'sme', 'corporate', 'housing', 'personal', 'by_loan_purpose_other']
      .map((field) => (`institution_specific_breakdown[${field}]`));
    const byLoanPurposeInputFields = byLoanPurposeFields.map((field) => originalElementFor(breakdownForm, `input[name="${field}"]`));
    const byLoanPurposeTotalField = document.getElementById('distribution_by_loan_purpose_total_sum');

    percentageFieldsSetup(bySectorInputFields, bySectorTotalField);
    percentageFieldsSetup(byLoanPurposeInputFields, byLoanPurposeTotalField);
  } else if (servicesOffered) {
    servicesOfferedSetup();
  } else if (generalForm) {
    institutionGeneralSetup();
  } else if (paiForm) {
    dynamicUnits();
  }
});
