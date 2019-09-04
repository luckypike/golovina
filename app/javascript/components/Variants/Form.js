import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

import { path } from '../Routes'
import { useI18n } from '../I18n'
import { Errors } from '../Form'

import page from '../Page.module.css'
import form from '../Form.module.css'
import buttons from '../Buttons.module.css'

Form.propTypes = {
  id: PropTypes.number,
  locale: PropTypes.string
}

export default function Form ({ id, locale }) {
  const I18n = useI18n(locale)

  const [values, setValues] = useState()
  const [dictionaries, setDictionaries] = useState()
  const [variant, setVariant] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const { data: { values, variant, dictionaries } } = await axios.get(id ? path('edit_variant_path', { id, format: 'json' }) : path('new_variant_path', { format: 'json' }))

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

  const handleChange = ({ target: { name, value } }) => {
    setValues({ ...values, [name]: value })
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
                  placeholder="Обязательно заполните цену..."
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

                <Errors errors={errors[`title_${locale}`]} />
              </div>
            )}
          </div>

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

          <div>
            {send && 'Настройки блока сохраняются..' }

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
