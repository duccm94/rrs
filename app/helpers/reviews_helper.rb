module ReviewsHelper
  def review_image_select review
    if review.image.exists?
      image_tag review.image.url(:medium),
        id: "image-preview",
        class: "img-responsive img-rounded"
    end
  end
end
