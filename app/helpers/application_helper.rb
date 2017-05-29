module ApplicationHelper
def full_title(page_title = '')
  base_title = "Adopt India"
  if page_title.empty?
    base_title
  else
    page_title + " | " + base_title
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
