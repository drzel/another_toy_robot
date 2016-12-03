class Input
  attr_reader :basename, :params

  def initialize(input)
    ary         = input.downcase.strip.split " "
    @basename   = ary.shift
    @params     = ary
    @classname = "#{@basename.capitalize}Command"
  end

  def to_command(target:)
    to_class.new target: target, params: @params
  end

  private

  def to_class
    if Object.const_defined? @classname
      Object.const_get @classname
    else
      InvalidCommand
    end
  end
end
