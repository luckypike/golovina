import React, { useState, useEffect, useRef } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

import { path } from '../Routes'
import { useI18n } from '../I18n'
import { Errors } from '../Form'

import page from '../Page.module.css'
import form from '../Form.module.css'
import buttons from '../Buttons.module.css'

Form.propTypes = {
  locale: PropTypes.string,
  id: PropTypes.number
}

export default function Form (props) {
  const image = useRef()

  const I18n = useI18n(props.locale)
  const { id, color, colors } = props

  const [values, setValues] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const { data: { values } } = await axios.get(id ? path('edit_color_path', { id, format: 'json' }) : path('new_color_path', { format: 'json' }))

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
      params.append(`color[${key}]`, value)
    })

    if (image.current.files[0]) params.append('color[image]', image.current.files[0])

    if (id) {
      _handleUpdate(params)
    } else {
      _handleCreate(params)
    }
  }

  const _handleUpdate = async params => {
    await axios.patch(
      path('color_path', { id }), params
    ).then(res => {
      window.location = res.headers.location
    }).catch((error) => {
      setErrors(error.response.data)
      setSend(false)
    })
  }

  const _handleCreate = async params => {
    await axios.post(
      path('colors_path'), params
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
      path('color_path', { id }),
      { data: { authenticity_token: document.querySelector('[name="csrf-token"]').content } }
    ).then(res => {
      window.location = res.headers.location
    })
  }

  if (!values) return null

  return (
    <div className={page.gray}>
      <div className={page.title}>
        <h1>Редактирование цвета</h1>
      </div>

      <div>
        <form onSubmit={handleSubmit}>
          <div className={form.el}>
            <label>
              <div className={form.label}>
                Название цвета
              </div>
            </label>

            <div className={form.input}>
              <input type="text" name="title" value={values.title} onChange={handleChange} />
            </div>
          </div>

          <div className={form.el}>
            <label>
              <div className={form.label}>
                Родительский цвет
              </div>
            </label>

            <div className={form.input}>
              <select name="parent_color_id" value={values.parent_color_id} onChange={handleChange}>
                <option value={null}></option>
                {colors.map((i, _) =>
                  <option key={_} disabled={values.parent_color_id} value={i.id}>{i.title}</option>
                )}
              </select>
            </div>
          </div>

          <div className={form.el}>
            <label>
              <div className={form.label}>
                Цвет
              </div>
            </label>

            {values.image.url == null &&
              <div className={form.input}>
                <input type="color" name="color" value={values.color} onChange={handleChange}/>
              </div>
            }

            {values.image.url &&
              <img src={color.image.url} />
            }
          </div>

          <div className={form.el}>
            <label>
              <div className={form.label}>
                Картинка
              </div>
            </label>

            <div className={form.input}>
              <input type="file" name="image" ref={image} />
            </div>
          </div>

          <div>
            {send && 'Настройки блока сохраняются..' }

            {!send &&
              <>
                <input type="submit" value="Сохранить" className={buttons.main} disabled={send} />
                <a href={path('colors_path', { id })} onClick={handleDestroy} className={buttons.destroy}>Удалить</a>
              </>
            }
          </div>
        </form>
      </div>
    </div>
  )
}
