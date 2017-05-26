require 'yaml'

module UsersHelper
  def image_for(user, size: 60)
    if user.image_url
      imageurl = "https://sports.ndtv.com/cricket/teams/6-india-teamprofile?s=#{size}"
      image_tag(user.image_url, alt: user.name, class: "gravatar")
    end
  end

  def parse_yaml_file
    ret = []
    byebug
    data = YAML.load_file 'config/socialinterests.yml'
    puts(data)
    data['socialinterests'].each do |hash|
      ret << SocialInterest.new(hash)
    end
    puts("Social interests count: #{ret.count}")
    ret
  end
end
