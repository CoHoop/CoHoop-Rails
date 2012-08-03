require 'simple_decorator'

class ModelInterface < SimpleDecorator

  # Public: Generic accessor for the model.
  #
  # Returns the decorated model.
  def model
    @component
  end

  # Public: Verifies if an attribute is blank, and handles the case where it is.
  #
  # attribute - The attribute name, as a Symbol.
  #
  # Examples
  #
  #   def university
  #     model.university = ''
  #     may_not_be_set(__method__) # <=> to may_not_be_set(:university)
  #   end
  #   # => 'University not specified'
  #
  # Returns the attribute value or a String indicating that it has not been specified.
  def may_not_be_set(attribute)
    value = model.send(attribute)
    if value.blank?
      "#{attribute.capitalize} not specified"
    else
      value
    end
  end

  # Public: Decorates an association
  #
  # association - The association as a Symbol.
  #
  # Returns nothing.
  def self.decorates_association(association, options = {})
    decorator = options[:with] || raise(ArgumentError, 'Decorates association must specify the decorator')

    define_method(association) do
      super_assoc = @component.send(association)
      return super_assoc if super_assoc.nil?

      return *super_assoc.map { |assoc| decorator.new(assoc) }
    end
  end
end
