require 'yapaas/cli'
require 'pathname'

module YAPAAS
  class CLI
    class Help < self
      @@dir = Pathname.new(__FILE__).dirname.join('help')
      @@files = Pathname.glob(@@dir.join("*.md"))

      def self.print(topic)
        puts @@dir.join("#{topic}.md").read
        exit 0
      end

      def self.topics
        @@files.map { |f| f.basename(f.extname).to_s }
      end

      def self.call(args)
        return super unless args.empty?
        print('topics')
      end

      option('-h', '--help', 'help on the help command') do
        die(help)
      end

      topics.each do |topic|
        command(topic) { print(topic) }
      end
    end
  end
end
