require 'rails_helper'
RSpec.describe User, type: :model do
    context "test vlidation model user" do
        it "ensure email is present" do
            user = User.new name: "Jpytachok", surname: "Jpytachkov", password: "qwerty"
            expect(user.valid?).to eq(false)
        end

        it "ensure name is present" do
            user = User.new email: "mail@mail.ru", surname: "Jpytachkov", password: "qwerty"
            expect(user.valid?).to eq(false)
        end

        it "ensure surname is present" do
            user = User.new email: "mail@mail.ru", name: "Jpytachok", password: "qwerty"
            expect(user.valid?).to eq(false)
        end

        it "ensure password is present" do
            user = User.new email: "mail@mail.ru", name: "Jpytachok", surname: "Jpytachkov"
            expect(user.valid?).to eq(false)
        end

        it "should be able to create user / ensure information is optional" do
            user = User.new email: "mail@mail.ru", name: "Jpytachok", surname: "Jpytachkov", password: "qwerty"
            expect(user.valid?).to eq(true)
        end
    end
end