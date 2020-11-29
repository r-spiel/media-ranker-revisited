class User < ApplicationRecord
  has_many :votes
  has_many :ranked_works, through: :votes, source: :work

  validates :username, presence: true
  validates :uid, uniqueness: { scope: :provider }

  def self.build_from_github(auth_hash)
    user = User.new
    user.uid = auth_hash[:uid]
    user.provider = auth_hash[:provider]
    user.username = auth_hash["info"]["nickname"]
    user.email = auth_hash["info"]["email"]

    # Note the user has not been saved yet.
    # We will save outside this method
    return user
  end

end
