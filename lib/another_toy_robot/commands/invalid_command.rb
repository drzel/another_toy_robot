class InvalidCommand
  include Command

  def execute
    puts "Invalid command"
  end
end
