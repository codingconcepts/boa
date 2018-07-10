module Boa
  struct Path
    getter path, handler
    @handler : Proc(Hash(String, String), Void)

    def initialize(@path : String, &handler : Hash(String, String) -> _)
      @handler = ->(args : Hash(String, String)) do
        handler.call(args)
      end
    end
  end
end
