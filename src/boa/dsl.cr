def command(path : String, &block : Array(String) -> _)
	Boa::PathHandler::INSTANCE.add_path(path, &block)
end