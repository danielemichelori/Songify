class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable,
         :omniauthable, omniauth_providers: [:twitter]

  enum gender: [:undisclosed, :female, :male, :other]

  def profile_image_uri(size = :mini)
  parse_encoded_uri(insecure_uri(profile_image_uri_https(size))) unless @attrs[:profile_image_url_https].nil?
  end

  def self.create_from_provider_data(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.username = auth.info.nickname
      user.first_name  = auth.info.name              # assuming the user model has a name
      user.email = auth.info.email            # since we are using twitter, which hasn't got any email, we'll just comment this
      user.password = Devise.friendly_token[0, 20]
      user.provider = auth.provider
      user.profile_image_url = auth[:extra][:raw_info][:profile_image_url]
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      user.skip_confirmation!
    end
  end

  def email_required?
    super && provider.blank?
  end

end
