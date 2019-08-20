import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

import { path } from '../Routes'
import { useI18n } from '../I18n'

import page from '../Page.module.css'

Form.propTypes = {
  values: PropTypes.object
}

export default function Form (props) {
  const I18n = useI18n(props.locale)
  const { id } = props

  const [values, setValues] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const { data: { values } } = await axios.get(id ? path('edit_slide_path', { id, format: 'json' }) : path('new_slide_path', { format: 'json' }))

      setValues(values)
    }

    _fetch()
  }, [id])

  const handleSubmit = e => {
    e.preventDefault()

    console.log(values)
  }

  const handleChange = ({ target: { name, value } }) => {
    setValues({ ...values, [name]: value })
  }

  // console.log(I18n.available_locales)

  if (!values) return null

  return (
    <div className={page.gray}>
      <div className={page.title}>
        <h1>Редактирование блока</h1>
      </div>

      <div>
        <form onSubmit={handleSubmit}>
          <div>
            <div>
              Текст
            </div>

            {I18n.available_locales.map(locale =>
              <div key={locale}>
                {locale}
                <input value={values[`name_${locale}`]} name={`name_${locale}`} onChange={handleChange} />
              </div>
            )}
          </div>

          <div>
            <input type="submit" value="Сохранить" />
          </div>
        </form>
      </div>
    </div>

  )
}
