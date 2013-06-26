class User < ActiveRecord::Base
  has_many :rooms, :dependent => :destroy
  has_many :reviews, :dependent => :destroy

  attr_accessible :bio, :email, :full_name, :location,
    :password, :password_confirmation

  validates_presence_of :email, :full_name, :location
  validates_length_of :bio, :minimum => 30, :allow_blank => false
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates_uniqueness_of :email

  scope :confirmed, where('confirmed_at IS NOT NULL')

  has_secure_password

  before_create :generate_token

  def generate_token
    self.confirmation_token = SecureRandom.urlsafe_base64
  end

  def confirm!
    return if confirmed?
    self.confirmed_at = Time.current
    self.confirmation_token = ''
    save!
  end

  def confirmed?
    confirmed_at.present?
  end

  def self.authenticate(email, password)
    confirmed.
    find_by_email(email).
    try(:authenticate, password)
  end
end
