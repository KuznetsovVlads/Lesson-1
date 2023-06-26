module ToAll
  def add_self_to_all
    self.class.all << self
  end
end
