class RecipeSerializer
  include JSONAPI::Serializer
  include Rails.application.routes.url_helpers

  attributes :id
  # attribute :recipe_image, if: Proc.new { |record| record.recipe_image.attached? }

  attribute :title do |recipe|
    if recipe.title.length < 36
      recipe.title
    else
      recipe.title[0...32] + ' ... '
    end
  end

  attribute :recipe_image_url do |recipe|
    unless recipe.recipe_image.attached?
      recipe.recipe_image.attach(io: File.open("#{Rails.root}/app/assets/images/Default_thump_image.png"), filename: 'Default_thump_image.png', content_type: 'image/png')
    end
    # always img processed
    recipe.recipe_image.variant(resize: "75x75!").processed.url
  end

  attribute :recipe_url do |object, params|
    params[:context].recipe_path(object)
  end
end
