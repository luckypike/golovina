import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'
import classNames from 'classnames'

import { path } from '../Routes'
import { useI18n } from '../I18n'
import { AwsContext } from '../Aws'

import Images from '../Images/Images'
import Video from '../Variants/Form/Video'

import buttons from '../Buttons.module.css'
import page from '../Page.module.css'
import form from '../Form.module.css'
import control from './Control/Control.module.css'

Form.propTypes = {
  id: PropTypes.number,
  locale: PropTypes.string,
  aws: PropTypes.object
}

export default function Form ({ id, locale, aws }) {
  const I18n = useI18n(locale)

  const [values, setValues] = useState()
  const [dictionaries, setDictionaries] = useState()
  const [kit, setKit] = useState()
  const [categories, setCategories] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const {
        data: {
          kit,
          values,
          dictionaries
        }
      } = await axios.get(id ? path('edit_kit_path', { id, format: 'json' }) : path('new_kit_path', { format: 'json' }))

      setKit(kit)
      setValues(values)
      setDictionaries(dictionaries)
    }

    _fetch()
    _getProducts()
  }, [id])

  const _getProducts = async () => {
    const {
      data: {
        categories
      }
    } = await axios.get(path('list_variants_path', { format: 'json' }))

    setCategories(categories)
  }

  const handleChange = ({ target: { name, value, type, checked } }) => {
    value = type === 'checkbox' ? checked : value

    setValues({ ...values, [name]: value })
  }

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
      kit: values,
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
      path('kit_path', { id }), params
    ).then(res => {
      window.location = res.headers.location
    }).catch((error) => {
      setErrors(error.response.data)
      setSend(false)
    })
  }

  const _handleCreate = async params => {
    await axios.post(
      path('kits_path'), params
    ).then(res => {
      window.location = res.headers.location
    }).catch((error) => {
      setErrors(error.response.data)
      setSend(false)
    })
  }

  const handleCategoryClick = (id) => {
    const newCategories = [...categories]
    const key = categories.findIndex(c => c.id === id)

    newCategories[key].active = !newCategories[key].active

    setCategories(newCategories)
  }

  const handleVariantClick = (variant) => {
    let variants = [...kit.variants]

    if (variants.map(v => v.id).includes(variant.id)) {
      variants = variants.filter(v => v.id !== variant.id)
    } else {
      variants.push(variant)
    }

    setKit({ ...kit, variants: variants })
    setValues({ ...values, variant_ids: variants.map(v => v.id) })
  }

  if (!values || !dictionaries) return null

  return (
    <AwsContext.Provider value={aws}>
      <div className={page.gray}>
        <div className={page.title}>
          <h1>{kit ? 'Редактирование образа' : 'Новый образ'}</h1>
        </div>

        <div>
          <form onSubmit={handleSubmit}>
            <div className={form.el}>
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

                </div>
              )}
            </div>

            {kit && kit.variants &&
              <div className={form.input}>
                <div className={form.label}>Товары в образе</div>
                <div className={control.kit_variants}>
                  {kit.variants.map(variant =>
                    <div key={variant.id}>{variant.title}</div>
                  )}
                </div>
              </div>
            }

            {categories &&
              categories.map((category, index) =>
                <div key={category.id} className={classNames(control.category, { [control.active]: category.active })}>
                  <div className={control.title} onClick={() => handleCategoryClick(category.id)}>
                    {category.title}
                    {kit && kit.variants && kit.variants.filter(v => v.category === category.id).length > 0 &&
                      <div className={control.selected}>({kit.variants.filter(v => v.category === category.id).length})</div>
                    }
                  </div>

                  <div className={control.variants}>
                    {category.variants &&
                      category.variants.map(variant =>
                        <div key={variant.id} className={classNames(control.item, {[control.active]: values.variant_ids.includes(variant.id)})} onClick={() => handleVariantClick(variant)}>
                          <div className={control.image}>
                            <div className={control.selected} />
                            <img src={variant.thumb}/>
                          </div>
                          <div>{variant.title}</div>
                        </div>
                      )
                    }
                  </div>
                </div>
              )
            }

            <div className={form.el}>
              <label>
                <div className={form.label}>
                  Категория
                </div>

                <div className={form.input}>
                  <select name="category_id" onChange={handleChange} value={values.category_id}>
                    <option value=''>Выберите категорию...</option>

                    {dictionaries.categories.map(category =>
                      <option key={category.id} value={category.id}>{category.title}</option>
                    )}
                  </select>
                </div>
              </label>
            </div>

            <div className={form.el}>
              <div className={form.label}>
                Изображения
              </div>

              <div className={form.input}>
                <Images
                  images={values.images_attributes}
                  onImagesChange={
                    images => setValues({
                      ...values,
                      images_attributes: images.map((i, index) => ({ id: i.id, weight: index + 1 })),
                      image_ids: images.map(i => i.id)
                    })
                  }
                />
              </div>
            </div>

            <div className={form.el}>
              <div className={form.label}>
                Видео
              </div>

              <div className={form.input}>
                <Video values={values} setValues={setValues} />
              </div>

              <div>
                <label>
                  <div className={form.checkbox}>
                    <input
                      type="checkbox"
                      value={values.video_hide}
                      name="video_hide"
                      onChange={handleChange}
                      checked={values.video_hide}
                    />

                    Скрыть видео в категориях
                  </div>
                </label>
              </div>
            </div>

            <div className={form.el}>
              <div className={form.label}>
                Статус
              </div>

              <div className={form.radio}>
                <div className={form.options}>
                  <label>
                    <input type="radio" name="state" checked={ values.state === 'active' } value="active" onChange={handleChange} />
                    Активный
                  </label>

                  <label>
                    <input type="radio" name="state" checked={ values.state === 'archived' } value="archived" onChange={handleChange} />
                    Архив
                  </label>
                </div>
              </div>
            </div>

            <div>
              {send && 'Настройки образа сохраняются..' }

              {!send &&
                <>
                  <input type="submit" value="Сохранить" className={classNames(buttons.main, buttons.big)} disabled={send} />
                </>
              }
            </div>
          </form>
        </div>
      </div>
    </AwsContext.Provider>
  )
}
