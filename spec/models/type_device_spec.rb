require 'rails_helper'

RSpec.describe TypeDevice, type: :model do
  it { should have_many(:devices).dependent(:destroy) }
  it { should validate_presence_of :name }
end
