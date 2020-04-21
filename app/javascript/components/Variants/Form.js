import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'
import classNames from 'classnames'
import update from 'immutability-helper'

import { path } from '../Routes'
import { useI18n } from '../I18n'
import { Errors } from '../Form'
import Images from '../Images/Images'

import page from '../Page.module.css'
import form from '../Form.module.css'
import buttons from '../Buttons.module.css'
import styles from './Variant.module.css'

Form.propTypes = {
  id: PropTypes.number,
  product_id: PropTypes.number,
  locale: PropTypes.string
}

export default function Form ({ id, product_id: productId, locale }) {
  const I18n = useI18n(locale)

  const [values, setValues] = useState()
  const [dictionaries, setDictionaries] = useState()
  const [variant, setVariant] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const {
        data: {
          values,
          variant,
          dictionaries
        }
      } = await axios.get(id ? path('edit_variant_path', { id, format: 'json' }) : path('new_variant_path', { format: 'json', query: { product_id: productId } }))

      setValues(values)
      setVariant(variant)
      setDictionaries(dictionaries)
    }

    _fetch()
  }, [id])

  const [send, setSend] = useState(false)
  const [errors, setErrors] = useState({})

  const handleSubmit = e => {
    e.preventDefault()

    if (send) {
      return null
    } else {
      setErrors({})
      setSend(true)
    }

    const params = {
      variant: values,
      authenticity_token: document.querySelector('[name="csrf-token"]').content
    }

    if (id) {
      _handleUpdate(params)
    } else {
      _handleCreate(params)
    }
  }

  const _handleUpdate = async params => {
    await axios.patch(
      path('variant_path', { id }), params
    ).then(res => {
      window.location = res.headers.location
    }).catch((error) => {
      setErrors(error.response.data)
      setSend(false)
    })
  }

  const _handleCreate = async params => {
    await axios.post(
      path('variants_path'), params
    ).then(res => {
      window.location = res.headers.location
    }).catch((error) => {
      setErrors(error.response.data)
      setSend(false)
    })
  }

  const handleChange = ({ target: { name, value, type, checked } }) => {
    value = type === 'checkbox' ? checked : value

    setValues({ ...values, [name]: value })
  }

  const handleImagesChange = images => {
    console.log(images)
  }

  const handleDestroy = async e => {
    e.preventDefault()

    // await axios.delete(
    //   path('variant_path', { id }),
    //   { data: { authenticity_token: document.querySelector('[name="csrf-token"]').content } }
    // ).then(res => {
    //   window.location = res.headers.location
    // })
  }

  if (!values || !dictionaries) return null

  return (
    <div className={page.gray}>
      <div className={page.title}>
        <h1>{variant ? `Редактирование: ${variant.title}` : 'Новый товар'}</h1>
      </div>

      <div>
        <form onSubmit={handleSubmit}>
          <div className={form.el}>
            <label>
              <div className={form.label}>
                Статус
              </div>

              <div className={form.input}>
                <select name="state" onChange={handleChange} value={values.state}>
                  {dictionaries.states.map(state =>
                    <option key={state} value={state}>{I18n.t(`variant.states.${state}`)}</option>
                  )}
                </select>
              </div>
            </label>

            <div className={form.hint}>
              Неопубликованные товары видны только редакторам, размещенные становятся видны всем, а архивные скрываются ото всех и найти их можно только через управление.
            </div>
          </div>

          <Product
            errors={errors}
            dictionaries={dictionaries}
            locale={locale}
            productValues={values.product_attributes}
            onValuesChange={
              productValues => setValues({ ...values, product_attributes: productValues })
            }
          />

          <div className={form.el}>
            <label>
              <div className={form.checkbox}>
                <input type="checkbox" name="latest" checked={values.latest} onChange={handleChange} />
                  Новый сезон
              </div>
            </label>
          </div>

          <div className={form.el}>
            <label>
              <div className={form.checkbox}>
                <input type="checkbox" name="bestseller" checked={values.bestseller} onChange={handleChange} />
                  Бестселлер
              </div>
            </label>
          </div>

          <div className={form.el}>
            <label>
              <div className={form.checkbox}>
                <input type="checkbox" name="sale" checked={values.sale} onChange={handleChange} />
                  Sale
              </div>
            </label>
          </div>

          <div className={form.el}>
            <label>
              <div className={form.checkbox}>
                <input type="checkbox" name="premium" checked={values.premium} onChange={handleChange} />
                  Premium
              </div>
            </label>
          </div>

          <div className={form.el}>
            <label>
              <div className={form.checkbox}>
                <input type="checkbox" name="morning" checked={values.morning} onChange={handleChange} />
                  Morning
              </div>
            </label>
          </div>

          <div className={form.el}>
            <label>
              <div className={form.checkbox}>
                <input type="checkbox" name="stayhome" checked={values.stayhome} onChange={handleChange} />
                  Stayhome
              </div>
            </label>
          </div>

          <div className={form.el}>
            <label>
              <div className={form.checkbox}>
                <input type="checkbox" name="last" checked={values.last} onChange={handleChange} />
                  Последний размер
              </div>
            </label>
          </div>

          <div className={form.el}>
            <label>
              <div className={form.checkbox}>
                <input type="checkbox" name="pinned" checked={values.pinned} onChange={handleChange} />
                  Закреплен
              </div>
            </label>
          </div>

          <div className={form.el}>
            <label>
              <div className={form.label}>
                Артикул
              </div>

              <div className={form.input}>
                <input
                  type="text"
                  value={values.code}
                  name="code"
                  onChange={handleChange}
                  placeholder="Укажите артикул если есть..."
                />
              </div>
            </label>

            <Errors errors={errors.code} />
          </div>

          <div className={form.el}>
            <label>
              <div className={form.label}>
                Стоимость
              </div>

              <div className={form.input}>
                <input
                  type="text"
                  value={values.price}
                  name="price"
                  onChange={handleChange}
                  placeholder="Укажите стоимость..."
                />
              </div>
            </label>

            <Errors errors={errors.price} />
          </div>

          <div className={form.el}>
            <label>
              <div className={form.label}>
                Стоимость со скидкой
              </div>

              <div className={form.input}>
                <input
                  type="text"
                  value={values.price_last}
                  name="price_last"
                  onChange={handleChange}
                />
              </div>
            </label>

            <Errors errors={errors.price_last} />
          </div>

          <div className={form.el}>
            <label>
              <div className={form.label}>
                Цвет
              </div>

              <div className={form.input}>
                <select name="color_id" onChange={handleChange} value={values.color_id}>
                  <option>Выберите цвет...</option>

                  {dictionaries.colors.map(color =>
                    <optgroup key={color.id} label={color.title}>
                      {color.colors.map(color =>
                        <option key={color.id} value={color.id}>{color.title}</option>
                      )}
                    </optgroup>
                  )}
                </select>
              </div>
            </label>

            <Errors errors={errors.color} />
          </div>

          <div className={form.el}>
            <div className={form.label}>
              Название для цвета
            </div>

            {I18n.available_locales.map(locale =>
              <div className={form.gl} key={locale}>
                <label>
                  <div className={form.label}>
                    {locale}
                  </div>

                  <div className={form.input}>
                    <input
                      type="text"
                      value={values[`title_${locale}`]}
                      name={`title_${locale}`}
                      onChange={handleChange}
                    />
                  </div>
                </label>
              </div>
            )}

            <div className={form.hint}>
              Название для выбранного цвета, можно оставить пустым — тогда будет браться общее название товара.
            </div>
          </div>

          <Availabilities
            // errors={errors}
            dictionaries={dictionaries}
            locale={locale}
            availabilitiesValues={values.availabilities_attributes}
            onValuesChange={
              availabilitiesValues => setValues({ ...values, availabilities_attributes: availabilitiesValues })
            }
          />

          <div className={form.el}>
            <div className={form.label}>
              Описание
            </div>

            {I18n.available_locales.map(locale =>
              <div className={form.gl} key={locale}>
                <label>
                  <div className={form.label}>
                    {locale}
                  </div>

                  <div className={form.input}>
                    <textarea value={values[`desc_${locale}`]} name={`desc_${locale}`} onChange={handleChange} />
                  </div>
                </label>
              </div>
            )}
          </div>

          <div className={form.el}>
            <div className={form.label}>
              Состав
            </div>

            {I18n.available_locales.map(locale =>
              <div className={form.gl} key={locale}>
                <label>
                  <div className={form.label}>
                    {locale}
                  </div>

                  <div className={form.input}>
                    <textarea value={values[`comp_${locale}`]} name={`comp_${locale}`} onChange={handleChange} />
                  </div>
                </label>
              </div>
            )}
          </div>

          {id &&
            <div className={form.el}>
              <label>
                <div className={form.label}>
                  Дата создания
                </div>

                <div className={form.input}>
                  <input
                    type="datetime-local"
                    value={values.created_at}
                    name="created_at"
                    onChange={handleChange}
                  />
                </div>
              </label>

              <Errors errors={errors.price_last} />
            </div>
          }

          <div className={form.el}>
            <div className={form.label}>
              Изображения
            </div>

            <div className={form.input}>
              <Images
                images={values.images_attributes}
                onImagesChange={
                  images => setValues({ ...values, images_attributes: images.map((i, index) => ({ id: i.id, weight: index + 1, favourite: i.favourite })) })
                }
              />
            </div>
          </div>

          <div>
            {send && 'Настройки товара сохраняются..' }

            {!send &&
              <>
                <input type="submit" value="Сохранить" className={buttons.main} disabled={send} />

                {id &&
                  <a href={path('category_path', { id })} onClick={handleDestroy} className={buttons.destroy}>Удалить</a>
                }
              </>
            }
          </div>
        </form>
      </div>
    </div>
  )
}

Product.propTypes = {
  errors: PropTypes.object,
  dictionaries: PropTypes.object,
  productValues: PropTypes.object,
  onValuesChange: PropTypes.func,
  locale: PropTypes.string
}

function Product ({ errors, dictionaries, productValues, onValuesChange, locale }) {
  const I18n = useI18n(locale)

  const [values, setValues] = useState(productValues)

  useEffect(() => {
    onValuesChange && onValuesChange(values)
  }, [values])

  const handleChange = ({ target: { name, value } }) => {
    setValues({ ...values, [name]: value })
  }

  return (
    <>
      <div className={form.el}>
        <div className={form.label}>
          Название
        </div>

        {I18n.available_locales.map(locale =>
          <div className={form.gl} key={locale}>
            <label>
              <div className={form.label}>
                {locale}
              </div>

              <div className={form.input}>
                <input
                  type="text"
                  value={values[`title_${locale}`]}
                  name={`title_${locale}`}
                  onChange={handleChange}
                  placeholder="Заполните название товара..."
                />
              </div>
            </label>

            <Errors errors={errors[`product.title_${locale}`]} />
          </div>
        )}
      </div>

      <div className={form.el}>
        <label>
          <div className={form.label}>
            Категория
          </div>

          <div className={form.input}>
            <select name="category_id" onChange={handleChange} value={values.category_id}>
              <option>Выберите категорию...</option>

              {dictionaries.categories.map(category =>
                <option key={category.id} value={category.id}>{category.title}</option>
              )}
            </select>
          </div>
        </label>

        <Errors errors={errors['product.category']} />
      </div>
    </>
  )
}

Availabilities.propTypes = {
  dictionaries: PropTypes.object,
  availabilitiesValues: PropTypes.array,
  onValuesChange: PropTypes.func
}

function Availabilities ({ dictionaries, availabilitiesValues, onValuesChange }) {
  const { stores, sizes } = dictionaries

  const [values, setValues] = useState(availabilitiesValues)

  useEffect(() => {
    onValuesChange && onValuesChange(values)
    // console.log(values)
  }, [values])

  const handleAddSize = (store, size) => {
    const key = values.findIndex(value => value.size_id === size && value.store_id === store)

    if (key >= 0) {
      setValues(update(values, { [key]: { $toggle: ['_destroy'] } }))
    } else {
      setValues([...values, { store_id: store, size_id: size, quantity: 0 }])
    }
  }

  const handleQuantityChange = (store, size, quantity) => {
    const key = values.findIndex(value => value.size_id === size && value.store_id === store)
    setValues(update(values, { [key]: { quantity: { $set: quantity } } }))
    // console.log(key)
    // console.log(store, size, quantity)
  }

  const hasSizeOnStore = (store, size) => {
    return values.find(value => value.size_id === size && value.store_id === store && !value._destroy)
  }

  return (
    <div className={form.stores}>
      {stores.map(store =>
        <React.Fragment key={store.id}>
          <div className={form.store}>
            <div className={form.input}>
              <div className={form.label}>
                Доступные размеры для {store.title}
              </div>

              <div className={styles.sizes}>
                {sizes.map(size =>
                  <div
                    key={size.id}
                    className={classNames(
                      styles.size,
                      {
                        [styles.active]: hasSizeOnStore(store.id, size.id)
                      }
                    )}
                    onClick={() => handleAddSize(store.id, size.id)}>{size.size}</div>
                )}
              </div>

              {/* <div className={styles.sizes}>
                {sizes.sort((a, b) => a.weight - b.weight).map((size, _) =>
                  <div key={_} className={classNames([styles.size], {[styles.active]: values.availabilities_attributes.find(s => s.size_id == size.id && s.store_id == store.id && !s._destroy)})} onClick={() => this.handleSizesChange(store.id, size.id)}>{size.size}</div>
                )}
              </div> */}
            </div>
          </div>

          {values.sort((a, b) => sizes.find(size => size.id === a.size_id).weight - sizes.find(size => size.id === b.size_id).weight).filter(value => value.store_id === store.id && !value._destroy).map((value, i) =>
            <div key={i} className={form.input}>
              <div className={form.label}>
                Количество размера {sizes.find(size => size.id === value.size_id).size}
              </div>

              <div className={form.input_input}>
                <input
                  type="text"
                  value={value.quantity}
                  onChange={({ target }) => handleQuantityChange(value.store_id, value.size_id, target.value)}
                />
              </div>
            </div>
            // <Availability
            //
            //   i={_i}
            //   key={_i}
            //   sizes={sizes}
            //   {...value}
            // />
          )}

          {/* {values.availabilities_attributes && values.availabilities_attributes.filter(s => s.store_id == store.id )&&
            values.availabilities_attributes.filter(s => s.store_id == store.id && !s._destroy).sort((a, b) => a.weight - b.weight).map((size, key) =>
              <div key={key} className={form.input}>
                <div className={form.label}>
                  Количество размера "{sizes.find(s => s.id == size.size_id).size}"
                </div>

                <div className={form.input_input}>
                  <input type="text" value={size.quantity} name={`size[${size.size_id}]`} onChange={this.handleQuantityChange(store.id, size.size_id)} />
                </div>
              </div>
            )
          } */}
        </React.Fragment>
      )}
    </div>
  )
}

// Availability.propTypes = {
//   onValueChange: PropTypes.func,
//   quantity: PropTypes.string,
//   sizes: PropTypes.array,
//   i: PropTypes.number,
//   size_id: PropTypes.number
// }
//
// function Availability (props) {
//   const { i, sizes, size_id: sizeId, onValueChange } = props
//
//   const [quantity, setQuantity] = useState(props.quantity)
//
//   useEffect(() => {
//     console.log(i, quantity)
//     onValueChange && onValueChange(i, quantity)
//   }, [quantity])
//
//   return (
//
//   )
// }
