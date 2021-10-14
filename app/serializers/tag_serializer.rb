class TagSerializer
  include JSONAPI::Serializer
  attributes :id, :name

  attribute :tag_url do |object, params|
    params[:context].autosearch_tag_path(object)
  end
end
