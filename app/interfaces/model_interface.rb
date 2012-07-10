require 'simple_decorator'

class ModelInterface < SimpleDecorator
  def model
    @component
  end

  # Public: returns the error classes if there were any.
  # This object is reset every time UserDecorator#may_not_be_specified is called.
  def error_classes
    @error_classes
  end

  protected
    # Protected: Provides a default content and hydrate the error classes
    # for a specified attribute.
    #
    # attribute - the attribute as a Symbol.
    # to_append - A message to append at the end of the attribute name
    #             if the attribute is unspecified. (default: 'not specified')
    #
    # Returns a String containing the error message or the value of the attribute.
    def may_not_be_specified attribute, to_append = 'not specified'
      @error_classes ||= []
      value = model.send(attribute)
      if value.blank?
        @error_classes = [ "blank #{attribute}" ]
        "#{attribute.capitalize} #{to_append}"
      else
        @error_classes = []
        value
      end
    end
end
