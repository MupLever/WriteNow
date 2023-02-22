require 'rails_helper'
RSpec.describe Match, type: :model do
    context "test validation model match" do
        let(:first_user) { User.create email: "mail@mail.ru", name: "Jpytachok", surname: "Jpytachkov", password: "qwerty" }
        let(:second_user) { User.create email: "mail@gmail.ru", name: "Jpytachok", surname: "Jpytachkov", password: "qwerty" }

        it "should be able to create match" do
            match = Match.new users: [first_user, second_user]
            expect(match.valid?).to eq(true)
        end

        it "should be able to create match through like method" do
            first_user.like(second_user)
            expect { second_user.like first_user }.to change { Match.count }.by(1)
        end
    end
end