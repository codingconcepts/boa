# Overview

Boa makes creating elegant CLIs like Docker and Kubernetes a doddle.  Simply express your sub-commands as blocks and have console arguments served up as `Hash(String, String)`.

## Installation

``` yaml
dependencies:
  boa:
    github: codingconcepts/boa
```

## Usage

``` ruby
require "boa"

# Matches ./your_app build <ARGS>
command "build" do |args|
  print "build", args, "\n"
end

# Matches ./your_app tool <ARGS>
command "tool" do |args|
  print "tool", args, "\n"
end

# Matches ./your_app tool format <ARGS>
command "tool format" do |args|
	print "tool format", args, "\n"
end

Boa.run
```

```
$ ./your_app tool format -a=1 -b 2 --c=3 --d 4 --e-e 5 --f-f=6 -g --h --i-i
tool format{"a" => "1", "b" => "2", "c" => "3", "d" => "4", "e-e" => "5", "f-f" => "6", "g" => "true", "h" => "true", "i-i" => "true"}
```

## Contributing

1. Fork it (<https://github.com/your-github-user/boa/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [codingconcepts](https://github.com/codingconcepts) codingconcepts - creator, maintainer
