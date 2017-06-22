require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it "should have from_name" do
    expect(Ticket.new(:from_email => "test@gmail.com",
                      :subject => "test",
                      :body => "Test test test test test")).not_to be_valid
  end

  it "should have from_mail" do
    expect(Ticket.new(:from_name => "Test",
                      :subject => "test",
                      :body => "Test test test test test")).not_to be_valid
  end

  it "should have subject" do
    expect(Ticket.new(:from_name => "Test",
                      :from_email => "test@gmail.com",
                      :body => "Test test test test test")).not_to be_valid
  end

  it "should have body" do
    expect(Ticket.new(:from_name => "Test",
                      :from_email => "test@gmail.com",
                      :subject => "test")).not_to be_valid
  end

  it "should be valid" do
    expect(Ticket.new(:from_name => "Test",
                      :from_email => "test@gmail.com",
                      :subject => "test",
                      :body => "Test test test test test")).to be_valid
  end
end
