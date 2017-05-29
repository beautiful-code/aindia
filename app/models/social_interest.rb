class SocialInterest < ApplicationRecord
  # attr_accessor :title, :description, :image_url
  validates :title, presence: true

  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "user_id",
                                  dependent:   :destroy
  has_many :followers, through: :active_relationships, source: :user_id

  # def initialize(hash)
  #   hash.each do |k,v|
  #     self.instance_variable_set("@#{k}", v.is_a?(Hash) ? Hashit.new(v) : v)
  #     self.class.send(:define_method, k, proc{self.instance_variable_get("@#{k}")})
  #     self.class.send(:define_method, "#{k}=", proc{|v| self.instance_variable_set("@#{k}", v)})
  #   end
  # end

  # Follows an interest.
  def follow(other_user_id)
    followers << other_user_id
  end

  # Unfollows an interest.
  def unfollow(other_user_id)
    followers.delete(other_user_id)
  end

  # Returns true if the current user is following the interest.
  def following?(other_user_id)
    followers.include?(other_user_id)
  end

end
