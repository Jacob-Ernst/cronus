class CreatedUserSerializer < ActiveModel::Serializer

  attributes :id, :first_name, :last_name, :email, :authentication_token

  def authentication_token
    object.generate_auth_token
  end
end
