# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '411577782547034', 'cddd51af47e5c306e61afdab2df351c2'
end

# Rails.application.config.middleware.use OmniAuth::Builder do
#   if Rails.env.development?
#     provider :facebook, 'STAGING_APP_ID', 'STAGING_APP_SECRET'
#   elsif Rails.env.production?
#     provider :facebook, 'PRODUCTION_APP_ID', 'PRODUCTION_APP_SECRET'
#   end
# end
