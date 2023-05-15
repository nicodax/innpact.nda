class EqualityCriterion
  def initialize query
    @query = query
  end

  def apply(scope)
    extended_scope(scope).where("#{selector} = ?", query)
  end

  protected

  attr_reader :query

  def extended_scope scope
    scope
  end

  def selector
    fail '''
        SubClasses of EqualityCriterion must implement selector() method
      '''
  end
end
