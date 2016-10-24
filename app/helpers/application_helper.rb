module ApplicationHelper
  def avatar_for(user, opts = {})
    opts[:alt] = user.name
    opts[:class] = 'avatar'
    image_tag user.picture, opts
  end
end
