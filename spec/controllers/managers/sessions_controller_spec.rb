require "rails_helper"

RSpec.describe Managers::SessionsController, :type => :controller do
  describe 'POST #create' do
    context "when password is incorrect" do
      let!(:user) { FactoryGirl.create(:user) }

      before(:each) do
        post :create, session: { email: 'test@gmail.com', password: 'qwerty' }
      end

      it "shows flash danger" do
        expect(flash[:danger]).to eq("Invalid email/password combination")
      end
    end

    context "when email is incorrect" do
      let!(:user) { FactoryGirl.create(:user) }

      before(:each) do
        post :create, session: { email: 'test', password: 'Qwertyu@' }
      end

      it "renders login template" do
        expect(response).to render_template("new")
      end
    end

    context "when credentials are correct" do
      let!(:user) { FactoryGirl.create(:user) }

      before(:each) do
        post :create, session: { email: 'test@gmail.com', password: 'Qwertyu@' }
      end

      it "redirects to tickets path" do
        expect(response).to redirect_to(tickets_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    it "redirects to login page" do
      allow(subject).to receive(:logged_in_manager).and_return(true)
      delete :destroy
      expect(response).to redirect_to(managers_login_path)
    end
  end
end
