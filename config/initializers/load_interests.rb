require 'yaml'

SOCIAL_INTERESTS = YAML.load_file("#{Rails.root}/config/socialinterests.yml")["socialinterests"]
