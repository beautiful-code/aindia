# frozen_string_literal: true

require 'yaml'

module UsersHelper
  def image_for(user)
    image_tag(user.image_url, alt: user.name, class: 'gravatar') if
    user.image_url
  end
end
