import React, { useState, useEffect, useRef } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'
import classNames from 'classnames'

import { path } from '../Routes'
import { useI18n } from '../I18n'
import { Errors } from '../Form'
import Video from '../Variants/Form/Video'

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
  const { id } = props

  const [slide, setSlide] = useState()
  const [values, setValues] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const {
        data: {
          slide,
          values
        }
      } = await axios.get(id ? path('edit_slide_path', { id, format: 'json' }) : path('new_slide_path', { format: 'json' }))

      setSlide(slide)
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
    Object.entries(values).map(([key, value]) => {
      params.append(`slide[${key}]`, value)
    })

    if (image.current.files[0]) params.append('slide[image]', image.current.files[0])

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
      path('slide_path', { id }),
      { data: { authenticity_token: document.querySelector('[name="csrf-token"]').content } }
    ).then(res => {
      window.location = res.headers.location
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
            <label>
              <div className={form.label}>
                Изображение
              </div>

              <div className={form.input}>
                <input type="file" name="image" ref={image} />
              </div>
            </label>

            <Errors errors={errors.image} />
          </div>

          <div className={form.el}>
            <div className={form.label}>
              Видео
            </div>

            <div className={form.input}>
              <Video
                values={values}
                setValues={setValues}
              />
            </div>
          </div>

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
            <div className={form.label}>
              Описание в блоке
            </div>

            {I18n.available_locales.map(locale =>
              <div className={form.gl} key={locale}>
                <label>
                  <div className={form.label}>
                    {locale}
                  </div>

                  <div className={form.input}>
                    <input value={values[`desc_${locale}`]} name={`desc_${locale}`} onChange={handleChange} />
                  </div>
                </label>

                <Errors errors={errors[`desc_${locale}`]} />
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
                <input value={values.weight} name="weight" onChange={handleChange} />
              </div>
            </label>

            <Errors errors={errors.weight} />
          </div>

          <div>
            {send && 'Настройки блока сохраняются..' }

            {!send &&
              <>
                <input type="submit" value="Сохранить" className={classNames(buttons.main, buttons.big)} disabled={send} />

                {id &&
                  <a href={path('slide_path', { id })} onClick={handleDestroy} className={buttons.destroy}>Удалить</a>
                }
              </>
            }
          </div>
        </form>
      </div>
    </div>

  )
}
