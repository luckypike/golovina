import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import axios from 'axios'
// import { deserialize } from 'jsonapi-deserializer'

import { path } from '../../Routes'
import { useI18n } from '../../I18n'
import { useForm, Errors } from '../../Form'

import styles from './Password.module.css'
import page from '../../Page.module.css'
import form from '../../Form.module.css'
import buttons from '../../Buttons.module.css'

Password.propTypes = {
  user: PropTypes.object.isRequired,
  locale: PropTypes.string.isRequired
}

export default function Password ({ user: userJSON, locale }) {
  const I18n = useI18n(locale)

  const {
    values,
    // setValues,
    // saved,
    // setSaved,
    handleInputChange,
    errors,
    pending,
    setErrors,
    onSubmit,
    cancelToken
  } = useForm({ password: '', password_confirmation: '' })

  const handleSubmit = async e => {
    e.preventDefault()

    await axios.patch(
      path('account_user_path', { format: 'json' }),
      { user: values },
      { cancelToken: cancelToken.current.token }
    ).then(res => {
      if (res.headers.location) window.location = res.headers.location
      // setSaved(true)
    }).catch(error => {
      setErrors(error.response.data)
    })
  }

  return (
    <div className={page.gray}>
      <div className={page.title}>
        <h1>{I18n.t('accounts.passwords.edit')}</h1>
      </div>

      <div className={styles.root}>
        <div className={form.tight}>
          <form className={classNames(form.root, styles.form)} onSubmit={onSubmit(handleSubmit)}>
            <Errors errors={errors.reset_password_token} />

            <div className={form.item}>
              <label>
                <div className={form.label}>
                  Новый пароль
                </div>

                <div className={form.input}>
                  <input
                    type="password"
                    autoFocus
                    autoComplete="new-password"
                    value={values.password}
                    name="password"
                    onChange={handleInputChange}
                  />
                </div>
              </label>

              <Errors errors={errors.password} />
            </div>

            <div className={form.item}>
              <label>
                <div className={form.label}>
                  Подтверждение пароля
                </div>

                <div className={form.input}>
                  <input
                    type="password"
                    autoComplete="off"
                    value={values.password_confirmation}
                    name="password_confirmation"
                    onChange={handleInputChange}
                  />
                </div>
              </label>

              <Errors errors={errors.password_confirmation} />
            </div>

            <div className={classNames(form.submit, styles.submit)}>
              <input
                type="submit"
                value={pending ? 'Меняем пароль...' : 'Сменить пароль'}
                className={classNames(buttons.main, { [buttons.pending]: pending })}
                disabled={pending}
              />
            </div>
          </form>
        </div>
      </div>
    </div>
  )
}
