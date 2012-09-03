class Numeric
  def to_bool
    self != 0
  end
  alias :to_b :to_bool
end
