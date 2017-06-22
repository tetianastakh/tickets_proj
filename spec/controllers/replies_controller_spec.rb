require "rails_helper"

RSpec.describe RepliesController, :type => :controller do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:ticket) { FactoryGirl.create(:ticket) }

  before(:each) do
    allow(subject).to receive(:current_user).and_return(user)
  end

  describe "POST create" do
    it "should create a reply" do
      expect {
        post :create, { :ticket_id => ticket.id, 
                        :reply => { :text => "Test test test test test",
                                    :ticket_id => ticket.id }}
      }.to change(Reply, :count).by(1)
    end

    it "should redirect to ticket page" do
      post :create, { :ticket_id => ticket.id,
                      :reply => { :text => "Test test test test test" }}
      expect(response).to redirect_to(ticket_path(ticket))
    end
  end
end
