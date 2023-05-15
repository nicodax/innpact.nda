class DatePickerInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options)
    value = input_html_options[:value]
    value ||= object.send(attribute_name) if object.respond_to? attribute_name
    input_html_options[:value] ||= value.strftime("%Y-%m-%d") if value.present?
    input_html_options[:type] = 'date'
    input_html_classes << "datepicker"

    super
  end
end
