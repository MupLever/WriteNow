require 'rails_helper'
RSpec.describe Match, type: :model do
    context "test vlidation model match" do
        it "should be able to create match / ensure information is optional" do
            first_user = User.new email: "mail@mail.ru", name: "Jpytachok", surname: "Jpytachkov", password: "qwerty"
            second_user = User.new email: "mail@gmail.ru", name: "Jpytachok", surname: "Jpytachkov", password: "qwerty"
            match = Match.new users: [first_user, second_user]
            expect(match.valid?).to eq(true)
        end
    end
end