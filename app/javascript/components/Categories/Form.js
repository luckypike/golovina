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

  useEffect(() => {
    const _fetch = async () => {
      const { data: { values, dictionaries } } = await axios.get(id ? path('edit_category_path', { id, format: 'json' }) : path('new_category_path', { format: 'json' }))

      setDictionaries(dictionaries)
      setValues(values)
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

    const params = new FormData()
    params.append('authenticity_token', document.querySelector('[name="csrf-token"]').content)
    Object.entries(values).map(([ key, value ]) => {
      params.append(`category[${key}]`, value)
    })

    if (id) {
      _handleUpdate(params)
    } else {
      _handleCreate(params)
    }
  }

  const _handleUpdate = async params => {
    await axios.patch(
      path('category_path', { id }), params
    ).then(res => {
      window.location = res.headers.location
    }).catch((error) => {
      setErrors(error.response.data)
      setSend(false)
    })
  }

  const _handleCreate = async params => {
    await axios.post(
      path('categories_path'), params
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

    await axios.delete(
      path('category_path', { id }),
      { data: { authenticity_token: document.querySelector('[name="csrf-token"]').content } }
    ).then(res => {
      window.location = res.headers.location
    })
  }

  if (!values || !dictionaries) return null

  return (
    <div className={page.gray}>
      <div className={page.title}>
        <h1>Редактирование блока</h1>
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
                    <option key={state} value={state}>{I18n.t(`category.states.${state}`)}</option>
                  )}
                </select>
              </div>
            </label>

            <div className={form.hint}>
              Неопубликованные категории видны только редакторам.
            </div>
          </div>

          <div className={form.el}>
            <label>
              <div className={form.label}>
                Код для ссылок
              </div>

              <div className={form.input}>
                <input type="text" value={values.slug} name="slug" onChange={handleChange} />
              </div>
            </label>

            <Errors errors={errors.slug} />
          </div>

          <div className={form.el}>
            <div className={form.label}>
              Название категории
            </div>

            {I18n.available_locales.map(locale =>
              <div className={form.gl} key={locale}>
                <label>
                  <div className={form.label}>
                    {locale}
                  </div>

                  <div className={form.input}>
                    <input type="text" value={values[`title_${locale}`]} name={`title_${locale}`} onChange={handleChange} />
                  </div>
                </label>

                <Errors errors={errors[`title_${locale}`]} />
              </div>
            )}
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
