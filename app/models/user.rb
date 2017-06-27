# frozen_string_literal: true

class User < ApplicationRecord
  has_many :issues, dependent: :destroy # created issues
  has_and_belongs_to_many :social_interests, class_name: 'SocialInterest'
  validates :name, presence: true
  validates :email, presence: true
  validates :oauth_token, presence: true

  # TODO: validates :name, :email, :oauth_token, presence: true
  has_and_belongs_to_many :supported_issues, class_name: 'Issue'
  # supported issues

  def self.from_omniauth(auth)
    # where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.save_from_auth(auth)
      user.save!
    end
  end

  def save_from_auth(auth)
    self.provider = auth.provider
    self.uid = auth.uid
    self.name = auth.info.name
    self.oauth_token = auth.credentials.token
    self.oauth_expires_at = Time.zone.at(auth.credentials.expires_at)
    self.image_url = auth.info.image
    self.email = auth.info.email
  end

  # Following Interests methods
  def following?(social_interest)
    social_interests.include?(social_interest)
  end

  def update_follow_interests(social_interest)
    if following?(social_interest)
      unfollow_interest(social_interest)
    else
      follow_interest(social_interest)
    end
    # TODO: following?(social_interest) ? unfollow_interest(social_interest) : follow_interest(social_interest)
  end

  def follow_interest(social_interest)
    social_interests << social_interest
  end

  def unfollow_interest(social_interest)
    social_interests.delete(social_interest)
  end

  # Support Issue methods

  def supporting?(issue)
    supported_issues.include?(issue)
  end

  def update_support_issue(issue)
    if supporting?(issue)
      unsupport_issue(issue)
    else
      support_issue(issue)
    end
    # TODO: Convert to a tertiary
  end

  def support_issue(issue)
    supported_issues << issue
  end

  def unsupport_issue(issue)
    supported_issues.delete(issue)
  end

  # TODO: Make this code work
=begin
  def ordered_relevant_issues
    social_interests.collect {|si| si.issues}.flatten.uniq.order_by(:created_at)
  end
=end

  def issues_based_on_my_interests
    if social_interests.count.positive?
      Issue.includes(:social_interests).where(social_interests:
        {
          id: social_interests.pluck(:id)
        })
    else
      Issue.all
    end
  end

end


=begin
Where to put the methods?
@user.relevant_issues
Issue.relevent_issues(user)

TDD
Describe user
  'I should see my relevant issues' do
    @user = User.find(...)
    @user.si = 'Cleanliness'

    @issue = Issue.create(tag: 'Cleanliness', ...)

    @user.relevant_issues.should include(@issue)
    
    @user.relevant_issues.should include(@issue)



  end

Issue.relevant_issues(user, location_of_user, ...)
1) look at si
2) look at the radius of hte user.

ReleventIssues.compute(user,
  

=end
