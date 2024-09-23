require 'rails_helper'

describe 'Post test' do
  let!(:post) { create(:post, title:'hoge',body:'body') }
  # describe 'top_path test' do
  #   before do
  #     visit top_path
  #   end
  #   context '表示の確認' do
  #     it 'トップ画面(top_path)に「ここはTopページです」が表示されているか' do
  #       expect(page).to have_content 'ここはTopページです'
  #     end
  #     it 'top_pathが"/top"であるか' do
  #       expect(current_path).to eq('/top')
  #     end
  #   end
  # end

  describe "new_post_path test" do
    before do
      visit new_post_path
    end
    context '表示の確認' do
      it 'new_post_path is"/posts/new"' do
        expect(current_path).to eq('/posts/new')
      end
      it 'Is there a Post botton' do
        expect(page).to have_button 'Post'
      end
    end
    context 'Post processing test' do
      it 'check the redirect destination after posting' do
        fill_in 'post[title]', with: Faker::Lorem.characters(number:10)
        fill_in 'post[body]', with: Faker::Lorem.characters(number:30)
        click_button '投稿'
        expect(page).to have_current_path post_path(Post.last)
      end
    end
  end

  describe "Post index test" do
    before do
      visit posts_path
    end
    context '表示の確認' do
      it 'Is the post shown correctly?' do
        expect(page).to have_content post.title
        expect(page).to have_link post.title
      end
    end
  end

  describe "post show page test" do
    before do
      visit post_path(post)
    end
    context '表示の確認' do
      it 'Is there a delete button' do
        expect(page).to have_link 'Delete'
      end
      it 'Is there a edit button' do
        expect(page).to have_link 'edit'
      end
    end
    context 'Check the link destination' do
      it 'Is the edit button linked to the editing screen' do
        edit_link = find_all('a')[3]
        edit_link.click
        expect(current_path).to eq('/posts/' + post.id.to_s + '/edit')
      end
    end
    context 'Post delete test' do
      it 'Detele post' do
        expect{ post.destroy }.to change{ Post.count }.by(-1)
      end
    end
  end

  describe 'Edit page test' do
    before do
      visit edit_post_path(post)
    end
    context '表示の確認' do
      it 'The title and body are shown on the form before editing' do
        expect(page).to have_field 'post[title]', with: post.title
        expect(page).to have_field 'post[body]', with: post.body
      end
      it 'save button is shown' do
        expect(page).to have_button 'Save'
      end
    end
    context 'Update test' do
      it 'the redirect destination correct after updating' do
        fill_in 'post[title]', with: Faker::Lorem.characters(number:10)
        fill_in 'post[body]', with: Faker::Lorem.characters(number:30)
        click_button 'save'
        expect(page).to have_current_path post_path(post)
      end
    end
  end
end