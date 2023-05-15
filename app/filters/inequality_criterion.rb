class InequalityCriterion
  def initialize query, operator
    @query, @operator = query, operator
  end

  def apply(scope)
    extended_scope(scope).where("#{selector} #{operator} ?", query).order("loans.created_at DESC")
  end

  protected

  attr_reader :query, :operator

  def extended_scope scope
    scope
  end

  def selector
    fail '''
        SubClasses of InequalityCriterion must implement selector() method
      '''
  end
end
