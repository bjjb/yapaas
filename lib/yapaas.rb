module YAPAAS
  VERSION = "0.1.0"

  autoload :Machine, 'yapaas/machine'
  
  module_function

  def machine?(name)
    Machine.all.map(&:name).include?(name)
  end
end
