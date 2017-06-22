require 'rails_helper'

RSpec.describe User, type: :model do
  it "should have valid email" do
    expect(User.new(:email => "test")).not_to be_valid
  end

  it "should rais error for invalid email" do
    user = User.create(:email => "test")
    expect(user.errors[:email]).to include("InvalidEmail")
  end

  it "should be valid" do
    expect(User.new(:email => "test1@mail.com", :password => "PIwerty%k")).to be_valid
  end

  it "should not rais error for invalid email" do
    user = User.create(:email => "test@mail.com")
    expect(user.errors[:email]).not_to include("InvalidEmail")
  end
end
