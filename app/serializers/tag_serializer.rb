include ActiveModel::Serialization
class TagSerializer < ActiveModel::Serializer

  attributes :id, :name

end
