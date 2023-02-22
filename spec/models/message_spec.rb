require 'rails_helper'
RSpec.describe Message, type: :model do
    context "test validation model message" do
        let(:first_user) { User.create email: "mail@mail.ru", name: "Jpytachok", surname: "Jpytachkov", password: "qwerty" }
        let(:second_user) { User.create email: "mail@gmail.ru", name: "Jpytachok", surname: "Jpytachkov", password: "qwerty" }
        
        it "ensure content is present" do
            match = Match.new users: [first_user, second_user]
            message = Message.new match: match, user: first_user
            expect(message.valid?).to eq(false)
        end

        it "should be able to create message / ensure information is optional" do
            match = Match.new users: [first_user, second_user]
            message = Message.new content: "fdfddfdf", match: match, user: first_user
            expect(message.valid?).to eq(true)
        end
    end
end