module Boa
	class Parser
		INSTANCE = Parser.new()
		
		def parse_args(args)
			h = {} of String => String
			
			i = 0
			while i < args.size
				k, v, inc = parse_arg(args, i)
				h[k] = v
		
				i += inc
			end
		
			h
		end
		
		def parse_arg(args, i) : {String,String,Int32}
			# Handle arguments in the form of ["-a=1"].
			if args[i].includes? "="
				parts = args[i].split "="
				k = parts[0].to_s.lstrip '-'
				v = parts[1].to_s
				return k, v, 1
			end
		
			parts = args[i..i+1]
			k = parts[0].to_s.lstrip '-'
		
			# Handle last arguments (will have to be Boolean flags)
			return k, "true", 1 if parts.size < 2
		
			# Handle arguments without a value (i.e. Boolean flags).
			v = parts[1].to_s
			return k, "true", 1 if v.starts_with? "-"
			
			# Handle arguments in the form of ["-a", "1"].
			return k, v, 2
		end
	end
end