class Search
  attr_accessor :categories, :companies, :levels, :locations

  def initialize(options = {})
    @categories = options[:categories]
    @companies = options[:companies]
    @levels = options[:levels]
    @locations = options[:locations]
  end
end