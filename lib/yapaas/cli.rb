require 'yapaas'
require 'optparse'

module YAPAAS
  class CLI < ::OptionParser
    autoload :Help, 'yapaas/cli/help'

    def initialize(command = nil)
      super do
        options.each do |args, block|
          on(*args, &block)
        end
      end
      @banner = usage
    end

    def self.command_name=(command)
      @command_name = command
    end

    def self.command_name
      @command_name ||= name.downcase
    end

    def command_name
      @command_name ||= self.class.command_name
    end

    def commands
      @commands ||= self.class.commands
    end

    def options
      @options ||= self.class.options
    end

    def self.commands
      @commands ||= {}
    end

    def self.options
      @options ||= []
    end

    def self.command(name, callable = nil, &block)
      block = callable unless block_given?
      commands[name] = block
    end

    def self.option(*args, &block)
      options << [args, block]
    end

    def die(message, code = 1)
      self.class.die(message, code)
    end

    def call(args)
      puts "call(#{args.inspect})" if $debug
      die(help) if args.empty?
      order! do |command|
        die("Unknown command: #{command}") unless commands.key?(command)
        commands[command].call(args)
      end
    rescue InvalidOption => e
      die(e.message)
    end

    def self.call(args)
      new.call(args)
    end

    private
    def usage
      s = ['Usage:', 'yapaas', command_name]
      s << '[options]' unless options.empty?
      s << '[command] [arguments]' unless commands.empty?
      s.compact.join(' ')
    end

    def self.help
      @help ||= new.help
    end

    def self.die(message, code = 1)
      puts message
      exit code
    end

    option('-v', '--[no-]verbose', 'run more verbosely') do |verbose|
      $verbose = verbose
    end

    option('-D', '--[no-]debug', 'print out internals') do |debug|
      $debug = debug
    end

    option('-h', '--help', "you're reading it") do
      die(help, 0)
    end

    option('-V', '--version', "print the client's version") do
      die(YAPAAS::VERSION, 0)
    end

    command('help', Help)

    command('version') do
      die(YAPAAS::VERSION, 0)
    end
  end
end
