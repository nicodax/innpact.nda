class LoanValidator < Dry::Validation::Contract
  params do
    required(:institution_id).filled(:integer)
    required(:fund_id).filled(:integer)
    required(:im_group_id).filled(:integer)
    required(:creation_user_id).filled(:integer)
  end
end
