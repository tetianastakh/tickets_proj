require "rails_helper"

RSpec.describe TicketsController, :type => :controller do

  describe "GET index" do
    it "has a 200 status code" do
      allow(subject).to receive(:logged_in_manager).and_return(true)
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "POST create" do
    it "should create a new ticket" do
      expect {
        post :create, { :ticket => { :from_name => "Test",
                        :from_email => "test@gmail.com",
                        :subject => "test",
                        :body => "Test test test test test" }}
      }.to change(Ticket, :count).by(1)
    end

    it "should redirect to creating new ticket" do
      post :create, { :ticket => { :from_name => "Test",
                                   :from_email => "test@gmail.com",
                                   :subject => "test",
                                   :body => "Test test test test test" }}
      expect(response).to redirect_to(new_ticket_path)
    end
  end

  describe "PUT update" do
    before :each do
      @ticket = Ticket.create(:from_name => "Test",
                              :from_email => "test@gmail.com",
                              :subject => "test",
                              :body => "Test test test test test" )
      @attr = { :subject => "New" }
    end

    it "should update a ticket" do
      put :update, :id => @ticket.id, :ticket => @attr
      expect(@ticket.reload.subject).to eql @attr[:subject]
    end

    it "should redirect to tickets" do
      put :update, :id => @ticket.id, :ticket => @attr
      expect(response).to redirect_to(ticket_path(@ticket))
    end
  end
end
