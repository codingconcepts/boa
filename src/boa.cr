require "./boa/*"
require "levenshtein"

module Boa
  def self.run
    begin
      path, args = PathHandler::INSTANCE.lookup_path ARGV

      # Convert array args to a hash.
      hash = Parser::INSTANCE.parse_args(args)
      path.handler.call(hash)
    rescue ex : BestMatchException
      print ex.message
      exit 1
    rescue ex : NoMatchException
      print ex.message
      exit 1
    end
  end
end
