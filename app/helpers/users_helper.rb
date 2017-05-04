module UsersHelper
  def image_for(user, size: 60)
    if user.image_url
      imageurl = "https://sports.ndtv.com/cricket/teams/6-india-teamprofile?s=#{size}"
      image_tag(imageurl, alt: user.name, class: "gravatar")
    end
  end
end
