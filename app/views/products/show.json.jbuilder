json.photo image_tag(@product.photo.thumb.url)
json.title @product.title_safe
json.price number_to_rub(@product.price)
json.desc @product.desc
json.sizes @product.sizes
json.kit false
json.goto link_to 'Подробнее', @product, class: [:goto]