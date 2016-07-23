require 'pathname'
require 'json'

module YAPAAS
  class Machine
    attr_reader :path
    attr_reader :config_file
    attr_accessor :name

    def initialize(path)
      @path = Pathname.new(path)
      @name = @path.basename.to_s
    end

    def run(command)
      ENV['DOCKER_TLS_VERIFY'] = "1"
      ENV['DOCKER_HOST'] = host
      ENV['DOCKER_CERT_PATH'] = cert_path
      system("ssh #{command}")
    end

    def host
      "tcp://#{config['Driver']['IPAddress']}:2376"
    end

    def cert_path
      config['HostOptions']['AuthOptions']['CertDir']
    end

    {
      server_key: 'server_key.pem',
      config_file: 'config.json',
      public_key: 'id_rsa.pub',
      server_cert: 'server.pem',
      private_key: 'id_rsa',
      cert: 'cert.pem',
      key: 'key.pem',
      ca: 'ca.pem',
    }.each { |k, v| define_method(k) { @path.join(v) } }

    def config
      @config ||= JSON.parse(config_file.read)
    end

    def self.driver_name
      'Docker Machine'
    end

    def self.all
      Dir[path.join('*')].map { |path| new(path) }
    end

    def self.path
      @@path ||= Pathname.new("#{ENV['HOME']}/.docker/machine/machines")
    end

    def self.exists?(name)
      path.join(name).directory?
    end
  end
end
