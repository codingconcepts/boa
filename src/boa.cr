require "./boa/*"

module Boa
  def self.run
    block = PathHandler::INSTANCE.lookup_path ARGV.join(" ")
    block.handler.call(["hello", "there"])
  end

  class PathHandler
    INSTANCE = new
    property paths

    def initialize
      @paths = {} of String => Route #Proc(Array(String), Void)
    end

    def add_path(path : String, &block : Array(String) -> _)
      @paths[path] = Route.new(path, &block)
    end

    def lookup_path(path : String)
      @paths[path]
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

command "a" do |args|
  puts "doing a"
end

command "b" do |args|
  puts "doing b"
end

command "c" do |args|
  puts "doing c"
end

Boa.run