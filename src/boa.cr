require "./boa/*"
require "levenshtein"

module Boa
  def self.run
    begin
      path, args = PathHandler::INSTANCE.lookup_path ARGV
      path.handler.call(args)
    rescue ex : BestMatchException
      print ex.message
      exit 1
    rescue ex : NoMatchException
      print ex.message
      exit 1
    end
  end
end

command "build" do |args|
  puts "running build with #{args}"
end

command "tool" do |args|
  puts "running tool with #{args}"
end

command "tool format" do |args|
  puts "running tool > format with #{args}"
end

Boa.run
