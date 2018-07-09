def command(path : String, &block : Hash(String, String) -> _)
	Boa::PathHandler::INSTANCE.add_path(path, &block)
end