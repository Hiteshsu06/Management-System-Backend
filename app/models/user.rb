class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable,
          jwt_revocation_strategy: self
  has_many :demo_companies, dependent: :destroy

  def self.signin_or_create_from_provider(provider_data)
    where(provider: provider_data[:provider], uid: provider_data[:uid]).first_or_create do |user|
      user.email = provider_data[:info][:email]
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation! # when you signup a new user, you can decide to skip confirmation
    end
  end

  has_one_attached :profile_image
  def profile_image_url
    Rails.application.routes.url_helpers.url_for(profile_image) if profile_image.attached?
  end

end
