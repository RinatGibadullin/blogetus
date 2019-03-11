require "rails_helper"

feature "As User I want to like some Story" do
  include_context "when user signed in"

  let!(:story) { create :story }
  let!(:liked_story) { create :story }
  let!(:like) { create :like, story: liked_story, user: current_user }

  scenario "when user likes other user post" do
    visit story_path(story)

    expect { click_on "Like" }.to change(story.likes.count).from(0).to(1)

    expect(page).to have_content("Dislike")
  end

  scenario "when user dislikes post" do
    visit story_path(liked_story)

    expect { click_on "Dislike" }.to change(story.likes.count).from(1).to(0)

    expect(page).to have_content("Like")
  end

  scenario "when user likes own post" do
    visit story_path(liked_story)

    expect(page).not_to have_content("Like")
  end

  scenario "when user likes already liked post" do
    visit story_path(liked_story)

    expect(page).not_to have_content("Like")
    expect(page).to have_content("Dislike")
  end
end
