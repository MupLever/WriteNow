require 'rails_helper'
RSpec.describe Message, type: :model do
    context "test validation model message" do
        it "ensure content is present" do
            first_user = User.new email: "mail@mail.ru", name: "Jpytachok", surname: "Jpytachkov", password: "qwerty"
            second_user = User.new email: "mail@gmail.ru", name: "Jpytachok", surname: "Jpytachkov", password: "qwerty"
            match = Match.new users: [first_user, second_user]
            message = Message.new match: match, user: first_user
            expect(message.valid?).to eq(false)
        end

        it "should be able to create message / ensure information is optional" do
            first_user = User.new email: "mail@mail.ru", name: "Jpytachok", surname: "Jpytachkov", password: "qwerty"
            second_user = User.new email: "mail@gmail.ru", name: "Jpytachok", surname: "Jpytachkov", password: "qwerty"
            match = Match.new users: [first_user, second_user]
            message = Message.new content: "fdfddfdf", match: match, user: first_user
            expect(message.valid?).to eq(true)
        end
    end
end