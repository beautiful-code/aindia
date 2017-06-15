class Issue < ApplicationRecord
  belongs_to :user
  # TODO: belongs_to :leader, :class_name => "User"

  default_scope -> { order(created_at: :desc) }
  mount_uploader :imageurl, PictureUploader

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :content, presence: true, length: { maximum: 20000 }
  has_and_belongs_to_many :social_interests, class_name: "SocialInterest"
  has_and_belongs_to_many :supported_users, class_name: "User"

  def is_supported_by_user?(suser)
    supported_users.include?(suser)
  end

  def get_supported_users_count
    ret = supported_users.count
  end

  def get_support_button_text(suser)
    if is_supported_by_user(suser)
      s = 'Unsupport'
    else
      s = 'Support'
    end
  end

  # def self.get_issues_filtered_on_the_basis_users_interests(c_user)
  #   c_user.
  # end

end
