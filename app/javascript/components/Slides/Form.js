import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

import { path } from '../Routes'
import { useI18n } from '../I18n'
import { Errors } from '../Form'
// import { useAxios } from '../Axios'

import page from '../Page.module.css'
import form from '../Form.module.css'

Form.propTypes = {
  locale: PropTypes.string,
  id: PropTypes.number
}

export default function Form (props) {
  const I18n = useI18n(props.locale)
  // const axios = useAxios()
  const { id } = props

  const [values, setValues] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const { data: { values } } = await axios.get(id ? path('edit_slide_path', { id, format: 'json' }) : path('new_slide_path', { format: 'json' }))

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

    const params = {
      slide: values,
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
      path('slide_path', { id }), params
    ).then(res => {
      window.location = res.headers.location
    }).catch((error) => {
      setErrors(error.response.data)
      setSend(false)
    })
  }

  const _handleCreate = async params => {
    await axios.post(
      path('slides_path'), params
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
      path('slide_path', { id })
    ).then(res => {
      window.location = res.headers.location
    }).catch((error) => {
      setErrors(error.response.data)
      setSend(false)
    })
  }

  if (!values) return null

  return (
    <div className={page.gray}>
      <div className={page.title}>
        <h1>Редактирование блока</h1>
      </div>

      <div>
        <form onSubmit={handleSubmit}>
          <div className={form.el}>
            <div className={form.label}>
              Текст в блоке
            </div>

            {I18n.available_locales.map(locale =>
              <div className={form.gl} key={locale}>
                <label>
                  <div className={form.label}>
                    {locale}
                  </div>

                  <div className={form.input}>
                    <input value={values[`name_${locale}`]} name={`name_${locale}`} onChange={handleChange} />
                  </div>
                </label>

                <Errors errors={errors[`name_${locale}`]} />
              </div>
            )}
          </div>

          <div className={form.el}>
            <label>
              <div className={form.label}>
                Ссылка с блока
              </div>

              <div className={form.input}>
                <input value={values.link} name="link" onChange={handleChange} />
              </div>
            </label>

            <Errors errors={errors.link} />
          </div>

          <div className={form.el}>
            <label>
              <div className={form.label}>
                Порядок
              </div>

              <div className={form.input}>
                <input value={values.weight} name="link" onChange={handleChange} />
              </div>
            </label>

            <Errors errors={errors.weight} />
          </div>

          <div>
            <input type="submit" value="Сохранить" />

            <a href={path('slide_path', { id })} onClick={handleDestroy}>Удалить</a>
          </div>
        </form>
      </div>
    </div>

  )
}
