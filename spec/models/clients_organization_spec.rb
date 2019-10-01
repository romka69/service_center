require 'rails_helper'

RSpec.describe ClientsOrganization, type: :model do
  it { should belong_to :client }
  it { should belong_to :organization }
end
