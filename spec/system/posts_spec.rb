require 'rails_helper'

RSpec.describe 'Post test', type: :system do
  let!(:user) { create(:user) } 
  let!(:post) { create(:post, title: 'title', body: 'body', user: user) } 

  before do
    sign_in user 
  end

  describe "new_post_path test" do
    before do
      visit new_post_path
    end
    
    context 'Display check' do
      it 'new_post_path is "/posts/new"' do
        expect(current_path).to eq('/posts/new')
      end
      
      it 'The Post button is displayed' do
        expect(page).to have_button 'Share'
      end
    end
    
    context 'Post processing test' do
      it 'Check the redirect destination after posting' do
        fill_in 'post[title]', with: Faker::Lorem.sentence
        fill_in 'post[body]', with: Faker::Lorem.paragraph
        click_button 'Share' 
        expect(page).to have_current_path post_path(Post.last)
      end
    end
  end

  describe "Post index test" do
    before do
      visit posts_path
    end
    
    context 'Display check' do
      it 'Is the post displayed correctly?' do
        expect(page).to have_content post.title
      end
    end
  end

  describe "Post show page test" do
    before do
      visit post_path(post)
    end
    
    context 'Display check' do
      it 'Delete button is present' do
        expect(page).to have_link 'Delete'
      end
      
      it 'Edit button is present' do
        expect(page).to have_link 'Edit'
      end
    end
    
    context 'Link destination check' do
      it 'Is the edit button linked to the edit page?' do
        find('a', text: 'Edit').click
        expect(current_path).to eq(edit_post_path(post))
      end
    end
    
    context 'Post delete test' do
      it 'Deletes the post' do
        expect { click_link 'Delete' }.to change { Post.count }.by(-1)
      end
    end
  end

  describe 'Edit page test' do
    before do
      visit edit_post_path(post)
    end
    
    context 'Display check' do
      it 'The form displays the title and body' do
        expect(page).to have_field 'post[title]', with: post.title
        expect(page).to have_field 'post[body]', with: post.body
      end
      
      it 'The save button is displayed' do
        expect(page).to have_button 'Save'
      end
    end
    
    context 'Update test' do
      it 'The redirect destination after update is correct' do
        fill_in 'post[title]', with: Faker::Lorem.sentence
        fill_in 'post[body]', with: Faker::Lorem.paragraph
        click_button 'Save'
        expect(page).to have_current_path post_path(post)
      end
    end
  end
end