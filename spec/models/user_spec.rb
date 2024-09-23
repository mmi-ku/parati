require 'rails_helper'

RSpec.describe 'User model test', type: :model do
  describe 'validation test' do
    subject { user.valid? }

    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }

    context 'name column' do
      it 'Must not be blank', spec_category: "" do
        user.name = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×', spec_category: "show validation and message" do
        user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇', spec_category: "show validation and message" do
        user.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '20文字以下であること: 20文字は〇', spec_category: "show validation and message" do
        user.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×', spec_category: "show validation and message" do
        user.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
      it '一意性があること', spec_category: "show validation and message" do
        user.name = other_user.name
        is_expected.to eq false
      end
    end

    context 'introductionカラム' do
      it '50文字以下であること: 50文字は〇', spec_category: "show validation and message" do
        user.introduction = Faker::Lorem.characters(number: 50)
        is_expected.to eq true
      end
      it '50文字以下であること: 51文字は×', spec_category: "show validation and message" do
        user.introduction = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end
  end

  describe 'Association test' do
    context 'Relationship with Post model' do
      it 'Must be 1:N', spec_category: "Basic association concepts and appropriate variable settings" do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
  end
end
