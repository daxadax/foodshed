module Gateways
  class Gateway
    InsertionError = Class.new(ArgumentError)

    def initialize(backend)
      @backend = backend
    end

    def insert(object)
      raise InsertionError, "Only hashes, please" unless object.is_a? Hash
      id = @backend.add(object)
      object.merge(id: id)
    end

    def get(id)
      @backend.get(id)
    end

    def all
      @backend.all
    end

    def update(object)
      return false unless object[:id]
      @backend.update(object)
    end

    def delete(id)
    end
  end
end
