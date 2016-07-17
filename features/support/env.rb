class UserProfile
  def initialize(name)
    @name = name
  end
end

class DockerMachine
  def initialize(name)
    @name = name
  end

  def env
    @env ||= self.class.env(@name)
  end

  def add_user(user)
    command = <<-COMMAND
      docker-machine scp #{ENV['HOME']}/.ssh/id_rsa.pub #{@name}:/tmp/#{user}.pub
      docker-machine ssh #{@name}
        sudo adduser -D #{user}
        sudo mkdir ~#{user}/.ssh
        sudo cp /tmp/#{user}.pub ~#{user}/.ssh/authorized_keys
        sudo chown -R #{user}:#{user} ~#{user}/.ssh
        sudo chmod 600 ~#{user}/.ssh/authorized_keys 
    COMMAND
  end

  def docker(cmd)
    system(env, "docker #{cmd}")
  end

  def ps
    docker('ps')
  end

  def kill(process)
    ps.grep(process).each { |p| p.kill }
  end

  def command(cmd)
    system("eval $(docker-machine env #{@name}) && #{cmd}")
  end

  def self.ls
    @docker_machines ||= `docker-machine ls -q`.strip.split(/\s+/)
  end

  def self.create(name)
    system("docker-machine create --driver virtualbox #{name}")
  end

  def self.ensure(name)
    create(name) unless ls.include?(name)
    use(name)
  end

  def self.use(name)
    new(name)
  end

  def self.machine(name)
    machines[name] ||= self.ensure(name)
  end

  def self.machines
    @@machines ||= {}
  end
end

module DockerMachineWorld
end

World(DockerMachineWorld)
