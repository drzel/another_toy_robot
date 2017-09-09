class Input
  attr_reader :basename, :params

  def initialize(input)
    ary = input.strip.downcase.split(" ")
    @basename = ary.shift
    @params = ary
  end
end
