require 'rails_helper'

RSpec.describe Client, type: :model do
  it { should validate_presence_of :fullname }
  it { should validate_presence_of :phone }
  it { should validate_numericality_of :phone }
end
