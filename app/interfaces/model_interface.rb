require 'simple_decorator'

class ModelInterface < SimpleDecorator
  def model
    @component
  end

  def may_not_be_set(attribute)
    value = model.send(attribute)
    if value.blank?
      "#{attribute.capitalize} not specified"
    else
      value
    end
  end
end
