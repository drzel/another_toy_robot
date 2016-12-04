class Command
  attr_accessor :target, :params

  def initialize(target: nil, params: nil)
    @target = target
    @params = params

    post_initialize
  end

  def post_initialize; end

  def execute
    return InvalidCommand.new.execute unless valid?
    issue_command
  end

  def valid?
    true
  end
end
