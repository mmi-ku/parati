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
    end

    describe 'Association test' do
      context 'Relationship with Post model' do
        it 'Must be 1:N', spec_category: "Basic association concepts and appropriate variable settings" do
          expect(User.reflect_on_association(:posts).macro).to eq :has_many
        end
      end
    end
  end
end
