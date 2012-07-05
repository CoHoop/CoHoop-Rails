class UserExhibit < DisplayCase::Exhibit
  class << self
    def applicable_to? o
      o.class.name == 'User'
    end
  end

  def user_name
    self.first_name + ' ' + self.last_name
  end
end