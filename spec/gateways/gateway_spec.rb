require 'spec_helper'

class GatewaySpec < FoodshedSpec
  let(:gateway) { Gateways::Gateway.new }
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
      persisted = gateway.insert(object)
      gateway.delete(persisted[:id])

      assert_nil gateway.get(persisted[:id])
    end

    it "doesn't remove other objects" do
      persisted = gateway.insert(object)
      persisted_two = gateway.insert(object.merge(name: 'another one'))
      gateway.delete(persisted[:id])

      assert_nil gateway.get(persisted[:id])
      assert_equal 'another one', gateway.get(persisted_two[:id])[:name]
    end
  end
end
