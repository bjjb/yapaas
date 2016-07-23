module YAPAAS
  autoload :VERSION, 'yapaas/version'
  autoload :Machine, 'yapaas/machine'
  
  module_function

  def machines
    Machine.all.map(&:name)
  end

  def machine?(name)
    machines.include?(name.to_s)
  end

  def machine(name)
    raise(NoSuchMachine, "there is no machine #{name}") unless machine?(name)
    machines.find { |m| m.name == name }
  end

  Error = Class.new(StandardError)
  NoSuchMachine = Class.new(Error)
end
