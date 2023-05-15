class LoanVersionValidator < Dry::Validation::Contract
  params do
    required(:status).filled(:string)
    required(:expected_disbursement_date).filled(:date)
    required(:probabilities).filled(:float).value(gteq?: 0).value(lteq?: 100)
    required(:currency_id).filled(:integer)
    required(:pool_id).filled(:integer)
    required(:loan_type_id).filled(:integer)
    required(:repayment_type_id).filled(:integer)
    required(:creation_user_id).filled(:integer)
  end
end
