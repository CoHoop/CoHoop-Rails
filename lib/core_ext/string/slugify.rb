class String
  def slugify
    self.gsub(/(\W|_)+/, '-').chomp('-').downcase
  end
end
