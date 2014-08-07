require 'spec_helper'
require 'user'

describe User do
  it { should validate_presence_of :firstname }
  it { should validate_presence_of :lastname }

  it "by default isn't admin" do
    expect(User.new).to_not be_admin
  end
end
