require 'pathname'

module YAPAAS
  class Machine
    class Driver
      class DockerMachine < self
        @@path = Pathname.new(ENV['HOME']).join(*%w(.docker machine machines))

        attr_reader :path
        attr_reader :config_file

        def initialize(path)
          @path = Pathname.new(path)
          @name = @path.basename.to_s
        end

        def config_file
          @path.join('config.json')
        end

        def ca
          @path.join('ca.pem')
        end

        def cert
          @path.join('cert.pem')
        end

        def private_key
          @path.join('id_rsa')
        end

        def public_key
          @path.join('id_rsa.pub')
        end

        def key
          @path.join('key.pem')
        end

        def server_key
          @path.join('server_key.pem')
        end

        def server_cert
          @path.join('server.pem')
        end

        def config
          @config ||= JSON.parse(config_file.read)
        end

        def self.driver_name
          'Docker Machine'
        end

        def self.all
          Dir[@@path.join('*')].map { |path| new(path) }
        end
      end
    end
  end
end
