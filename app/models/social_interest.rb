class SocialInterest < ApplicationRecord
  # attr_accessor :title, :description, :image_url
  validates :title, presence: true

  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  # def initialize(hash)
  #   hash.each do |k,v|
  #     self.instance_variable_set("@#{k}", v.is_a?(Hash) ? Hashit.new(v) : v)
  #     self.class.send(:define_method, k, proc{self.instance_variable_get("@#{k}")})
  #     self.class.send(:define_method, "#{k}=", proc{|v| self.instance_variable_set("@#{k}", v)})
  #   end
  # end

  # Follows an interest.
  def follow(other_user)
    followers << other_user
  end

  # Unfollows an interest.
  def unfollow(other_user)
    followers.delete(other_user)
  end

  # Returns true if the current user is following the interest.
  def following?(other_user)
    ret
  end

end
