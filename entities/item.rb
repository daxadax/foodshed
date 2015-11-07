module Entities
  class Item
    attr_accessor :id, :name, :type, :size, :quantity, :zone, :notes

    def self.create(attributes)
      created = Gateways::ItemGateway.new.insert(attributes)
      new(created)
    end

    def initialize(attributes = {})
      @id = attributes[:id]
      @name = attributes.fetch(:name)
      @type = attributes.fetch(:type)
      @quantity = attributes.fetch(:quantity)
      @zone = attributes.fetch(:zone)
      @size = attributes[:size]
      @notes = attributes[:notes]
    end
  end
end
