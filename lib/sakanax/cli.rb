require "sakanax"
require "thor"

module Sakanax
  class CLI < Thor
    desc "hello", "say 'hello world!'."
    def hello
      puts "Hello World!"
    end
  end
end
