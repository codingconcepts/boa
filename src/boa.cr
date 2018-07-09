require "./boa/*"
require "levenshtein"

module Boa
  def self.run
    begin
      route, args = PathHandler::INSTANCE.lookup_path ARGV
      route.handler.call(args)
    rescue ex : NoMatchException
      print ex.message
    end
  end

  # TODO: Move into exceptions file.
  class NoMatchException < Exception
  end

  # TODO: Move into path_handler file.
  class PathHandler
    INSTANCE = new
    property paths

    def initialize
      @paths = {} of String => Route
    end

    def add_path(path : String, &block : Array(String) -> _)
      @paths[path] = Route.new(path, &block)
    end

    # Finds the best match in a Hash for an array of strings, the
    # best match being the longest key found.
    # For example, the following would return the value at @paths["build stuff"]
    # @paths.keys = ["build", "build stuff"]
    # argv        = ["build", "stuff"]
    def lookup_path(argv) : {Route, Array(String)}
      distances = {} of Int32 => String

      @paths.keys.sort_by { |k| k.size }.reverse.each do |k|
        key_parts = k.split(" ")
        arg_parts = argv.first(key_parts.size)
        return @paths[k], argv.skip(arg_parts.size) if key_parts == arg_parts

        d = Levenshtein.distance(k, arg_parts.join(" "))
		    distances[d] = k unless distances.has_key?(d)
      end

      # We didn't find a matching route, use Levenshtein distance to
      # find the next most suitable match and return it as an error.
      raise NoMatchException.new("Did you mean '#{distances[distances.keys.sort.first()]}'?\n")
    end
  end

  struct Route
    getter path, handler
    @handler : Proc(Array(String), Void)

    def initialize(@path : String, &handler : Array(String) -> _)
      @handler = ->(args : Array(String)) do
        handler.call(args)
      end
    end
  end
end

def command(path : String, &block : Array(String) -> _)
  Boa::PathHandler::INSTANCE.add_path(path, &block)
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
