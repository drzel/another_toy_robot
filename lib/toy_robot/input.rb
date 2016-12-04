class Input
  def initialize(input)
    @input = input.strip.downcase.split " "
  end

  def basename
    @basename ||= @input.first
  end

  def params
    @params ||= @input.drop 1
  end

  def classname
    @classname ||= "#{basename.capitalize}Command"
  end

  def to_class
    if Object.const_defined? classname
      Object.const_get classname
    else
      InvalidCommand
    end
  end

  def new_command(target)
    to_class.new target: target, params: params
  end
end
