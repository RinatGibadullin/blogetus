class UserDecorator < BaseDecorator
  def blogs
    @blogs ||= object.blogs
  end

  def stories
    @stories ||= object.stories.published
  end

  def drafts
    @drafts ||= object.stories.not_published
  end

  def blogs_count
    @blogs_count ||= object.blogs_count
  end

  def stories_count
    @stories_count ||= object.stories_count
  end
end
