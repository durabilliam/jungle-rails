class User < ActiveRecord::Base

  has_secure_password
  #validates :email, uniqueness: { case_sensitive: false }
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :password, :length => {:minimum => 8 }
  before_save { self.email.downcase!}

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.downcase.gsub(" ", "").strip.squish)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end

end
