class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :first_name, :last_name, :full_address, :gender, :created_at, :updated_at, :profile_image_url
end
