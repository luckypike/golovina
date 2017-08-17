json.photo image_tag(@kit.photo.thumb.url)
json.title @kit.title
json.price number_to_rub(@kit.price)
json.kit true
json.goto link_to "Подробнее #{@kit.products.size} товара", @kit, class: [:goto]