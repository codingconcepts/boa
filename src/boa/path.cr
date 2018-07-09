module Boa
	struct Path
		getter path, handler
		@handler : Proc(Array(String), Void)

		def initialize(@path : String, &handler : Array(String) -> _)
			@handler = ->(args : Array(String)) do
			handler.call(args)
			end
		end
	end
end