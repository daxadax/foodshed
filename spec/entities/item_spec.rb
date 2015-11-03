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
    let(:result) { Entitites::Item.create(attributes) }
    it 'builds an item and saves it in the gateway' do
      skip
      assert_expected_attributes
    end
  end

  def assert_expected_attributes
    assert_nil result.size
    assert_nil result.notes
    assert_equal 'apples', result.name
    assert_equal 'fruit', result.type
    assert_equal 5, result.quantity
    assert_equal 3, result.zone
  end
end
