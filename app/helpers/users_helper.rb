# frozen_string_literal: true

require 'yaml'

module UsersHelper
  def image_for(user, size: 60)
    if user.image_url
      image_tag(user.image_url, alt: user.name, class: "gravatar")
    end
  end
end
