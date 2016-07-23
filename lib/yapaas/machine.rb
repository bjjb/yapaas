module YAPAAS
  class Machine
    autoload :Driver, 'yapaas/machine/driver'

    def self.all
      Driver.all.map(&:all).flatten
    end
  end
end

require 'yapaas/machine/driver/generic'
require 'yapaas/machine/driver/docker_machine'
