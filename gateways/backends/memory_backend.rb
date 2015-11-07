module Gateways
  module Backends
    class MemoryBackend
      def initialize
        @memory = []
        @id = 0
      end

      def add(object)
        added_object = object.merge(id: next_id)
        @memory << added_object
        added_object[:id]
      end

      def get(id)
        @memory.detect { |obj| obj[:id] == id }
      end

      def all
        @memory
      end

      def update(obj)
        @memory.detect do |persisted|
          if persisted[:id] == obj[:id]
            persisted.update(persisted) { |k,v| persisted[k] = obj[k] }
          end
        end
      end

      def delete(id)
        @memory.delete_if { |h| h[:id] == id }
      end

      private

      def next_id
        @id += 1
      end
    end
  end
end
