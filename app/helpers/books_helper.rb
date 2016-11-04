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
end
