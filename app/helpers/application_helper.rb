module ApplicationHelper
  def avatar_for(user)
    image_tag user.picture,
      alt: user.name, title: "#{user.name} (#{user.uid})", class: 'avatar'
  end
end
