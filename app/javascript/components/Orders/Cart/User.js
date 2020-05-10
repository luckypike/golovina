import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'

import { Errors } from '../../Form'

import { useI18n } from '../../I18n'
import form from '../../Form.module.css'

User.propTypes = {
  errors: PropTypes.object,
  userValues: PropTypes.object,
  onValuesChange: PropTypes.func,
  locale: PropTypes.string
}

export default function User ({ errors, userValues, onValuesChange, locale }) {
  const I18n = useI18n(locale)

  const [values, setValues] = useState(userValues)

  useEffect(() => {
    onValuesChange && onValuesChange(values)
  }, [values])

  const handleInputChange = ({ target: { name, value } }) => {
    setValues({ ...values, [name]: value })
  }

  return (
    <>
      <div className={form.el}>
        <label>
          <div className={form.label}>
            {I18n.t('user.name')}
          </div>
        </label>

        <div className={form.input}>
          <input type="text" name="name" value={values.name} onChange={handleInputChange} />
        </div>

        <Errors errors={errors['user.name']} />
      </div>

      <div className={form.el}>
        <label>
          <div className={form.label}>
            {I18n.t('user.sname')}
          </div>
        </label>

        <div className={form.input}>
          <input type="text" name="sname" value={values.sname} onChange={handleInputChange} />
        </div>

        <Errors errors={errors['user.sname']} />
      </div>

      <div className={form.el}>
        <label>
          <div className={form.label}>
            {I18n.t('user.email')}
          </div>
        </label>

        <div className={form.input}>
          <input type="email" name="email" value={values.email} onChange={handleInputChange} />
        </div>

        <Errors errors={errors['user.email']} />
      </div>

      <div className={form.el}>
        <label>
          <div className={form.label}>
            {I18n.t('user.phone')}
          </div>
        </label>

        <div className={form.input}>
          <input type="tel" name="phone" value={values.phone} onChange={handleInputChange} />
        </div>

        <Errors errors={errors['user.phone']} />
      </div>
    </>
  )
}
