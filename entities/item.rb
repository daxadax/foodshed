module Entities
  class Item
    attr_accessor :name, :type, :size, :quantity, :zone, :notes

    def initialize(attributes = {})
      @name = attributes.fetch(:name)
      @type = attributes.fetch(:type)
      @quantity = attributes.fetch(:quantity)
      @zone = attributes.fetch(:zone)
      @size = attributes[:size]
      @notes = attributes[:notes]
    end
  end
end
