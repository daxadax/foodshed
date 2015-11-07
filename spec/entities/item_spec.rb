require 'spec_helper'

class ItemSpec < FoodshedSpec
  let(:attributes) do
    {
      name: 'apples',
      type: 'fruit',
      size: nil,
      quantity: 5,
      zone: 3
    }
  end
  let(:result) { Entities::Item.new(attributes) }

  it 'gives access to basic attributes' do
    assert_expected_attributes
  end

  describe 'create' do
    let(:result) { Entities::Item.create(attributes) }
    it 'builds an item and saves it in the gateway' do
      assert_expected_attributes(id: 1)
    end
  end

  def assert_expected_attributes(id: nil)
    assert_nil result.size
    assert_nil result.notes
    assert_equal id, result.id
    assert_equal 'apples', result.name
    assert_equal 'fruit', result.type
    assert_equal 5, result.quantity
    assert_equal 3, result.zone
  end
end
