class SocialInterest < ApplicationRecord
  validates :title, presence: true
  has_and_belongs_to_many :users
  has_and_belongs_to_many :issues

  # def initialize(hash)
  #   hash.each do |k,v|
  #     self.instance_variable_set("@#{k}", v.is_a?(Hash) ? Hashit.new(v) : v)
  #     self.class.send(:define_method, k, proc{self.instance_variable_get("@#{k}")})
  #     self.class.send(:define_method, "#{k}=", proc{|v| self.instance_variable_set("@#{k}", v)})
  #   end
  # end

end
