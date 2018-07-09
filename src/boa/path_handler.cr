module Boa
	class PathHandler
		INSTANCE = new
		property paths

		def initialize
			@paths = {} of String => Path
		end

		def add_path(path : String, &block : Array(String) -> _)
			@paths[path] = Path.new(path, &block)
		end

		# Finds the best match in a Hash for an array of strings, the
		# best match being the longest key found.
		# For example, the following would return the value at @paths["build stuff"]
		# @paths.keys = ["build", "build stuff"]
		# argv        = ["build", "stuff"]
		def lookup_path(argv) : {Path, Array(String)}
			distances = {} of Int32 => String

			@paths.keys.sort_by { |k| k.size }.reverse.each do |k|
			key_parts = k.split(" ")
			arg_parts = argv.first(key_parts.size)
			return @paths[k], argv.skip(arg_parts.size) if key_parts == arg_parts

			d = Levenshtein.distance(k, arg_parts.join(" "))
				distances[d] = k unless distances.has_key?(d)
			end

			# We didn't find a matching path, use Levenshtein distance to
			# find the next most suitable match and return it as an error.
			best = distances.keys.sort.first()
			raise BestMatchException.new("Did you mean '#{distances[best]}'?\n") unless best > 3
			raise NoMatchException.new("No matches found.\n")
		end
	end
end