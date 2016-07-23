module YAPAAS
  class Machine
    class Driver
      attr_reader :name

      def to_s
        "#{name} (#{self.class.driver_name})"
      end

      def self.driver_name
        self.class.name
      end
      
      def self.inherited(klass)
        @@drivers[klass.name] = klass
      end

      def self.all
        @@drivers.values
      end

      @@drivers = {}
    end
  end
end
