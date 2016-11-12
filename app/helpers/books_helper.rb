module BooksHelper
  def book_image_select book
    if book.image.exists?
      image_tag book.image.url(:medium),
        id: "image-preview",
        class: "img-responsive img-rounded"
    else
      image_tag "default_image.jpg",
        id: "image-preview",
        class: "img-responsive img-rounded"
    end
  end

  def load_image_index book
    if book.image.exists?
      image_tag  book.image, alt: "Nature", style: "width:100%"
    else
      image_tag "default_image.jpg", alt: "Nature", style: "width:100%"
    end
  end

  def load_image_small_index book
    if book.image.exists?
      image_tag  book.image, alt: "Image", class: "w3-left w3-margin-right", style: "width:50px"
    else
      image_tag "default_image.jpg", alt: "Image", class: "w3-left w3-margin-right", style: "width:50px"
    end
  end
end
