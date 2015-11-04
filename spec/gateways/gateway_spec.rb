require 'spec_helper'

class GatewaySpec < FoodshedSpec
  let(:fake_backend)  { FakeBackend.new }
  let(:gateway)       { Gateways::Gateway.new(fake_backend) }
  let(:object) do
    {
      id: nil,
      name: 'generic object'
    }
  end

  describe "insert" do
    it "ensures the added object is a Hash" do
      assert_failure { gateway.insert(23) }
    end

    it "returns the inserted object on success" do
      result = gateway.insert(object)
      assert_equal object.merge(id: 1), result
    end
  end

  describe "get" do
    it "returns nil if the the object is not persisted" do
      assert_nil gateway.get(23)
    end

    it "stores the serialized data in database" do
      id = gateway.insert(object)[:id]
      assert_equal object.merge(id: id), gateway.get(id)
    end
  end

  describe "update" do
    describe "without a persisted object" do
      it "returns false" do
        assert_equal gateway.update(object), false
      end
    end

    it "updates any changed attributes" do
      persisted = gateway.insert(object)
      gateway.update(persisted.merge(name: 'a new name'))
      result = gateway.get(persisted[:id])

      refute_equal persisted, result
      assert_equal 'a new name', result[:name]
    end
  end

  describe "all" do
    it "returns an empty array if the gateway is empty" do
      assert_empty gateway.all
    end

    it "returns all items in the gateway" do
      gateway.insert(object)
      gateway.insert(object.merge(name: 'another object'))
      result = gateway.all

      assert_equal 2, result.size
      assert_equal ['generic object', 'another object'], result.map { |obj| obj[:name] }
    end
  end

  describe "delete" do
    it "removes the object associated with the given id" do
      uid = gateway.insert(object)
      gateway.delete(uid)

      assert_nil gateway.get(uid)
    end

    it "doesn't remove other objects" do
      skip
      uid = gateway.insert(object)
      second_uid = gateway.insert()#another one
      gateway.delete(uid)

      assert_nil gateway.get(uid)
      assert_stored gateway.get(second_uid)
    end
  end

  class FakeBackend
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

    private

    def next_id
      @id += 1
    end
  end
end
