require 'rails_helper'

RSpec.describe 'Post model test', type: :model do
  describe 'validation test' do
    subject { post.valid? }

    let(:user) { create(:user) }
    let(:post) { build(:post, user: user) }

    context 'title column' do
      it 'Must not be blank', spec_category: "show validation and message" do
        post.title = ''
        is_expected.to eq false
        post.validate 
        expect(post.errors[:title]).to include("can't be blank")
      end
    end

    context 'body column' do
      it 'Must not be blank', spec_category: "show validation and message" do
        post.body = ''
        is_expected.to eq false
        post.validate
        expect(post.errors[:body]).to include("can't be blank")
      end
    end
  end

  describe 'Association test' do
    context 'Relationship with User model' do
      it 'Must be N:1', spec_category: "Basic association concepts and appropriate variable settings" do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end