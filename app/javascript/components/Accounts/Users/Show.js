import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import axios from 'axios'
import { deserialize } from 'jsonapi-deserializer'

import { path } from '../../Routes'
import { useI18n } from '../../I18n'
import { useForm, Errors } from '../../Form'

import styles from './Show.module.css'
import page from '../../Page.module.css'
import form from '../../Form.module.css'
import buttons from '../../Buttons.module.css'

Show.propTypes = {
  user: PropTypes.object.isRequired,
  locale: PropTypes.string.isRequired
}

export default function Show ({ user: userJSON, locale }) {
  const I18n = useI18n(locale)
  const user = deserialize(userJSON)

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
  } = useForm({ name: user.name, sname: user.sname, phone: user.phone, email: user.email })

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
        <h1>{I18n.t('accounts.users.show')}</h1>
      </div>

      <div className={styles.root}>
        <div className={form.tight}>
          <form className={classNames(form.root, styles.form)} onSubmit={onSubmit(handleSubmit)}>
            <Errors errors={errors.reset_password_token} />

            <div className={form.item}>
              <label>
                <div className={form.label}>
                  Электронная почта
                </div>

                <div className={form.input}>
                  <input
                    type="text"
                    value={values.email}
                    name="email"
                    onChange={handleInputChange}
                  />
                </div>
              </label>

              <Errors errors={errors.email} />
            </div>

            <div className={form.item}>
              <label>
                <div className={form.label}>
                  Имя
                </div>

                <div className={form.input}>
                  <input
                    type="text"
                    value={values.name}
                    name="name"
                    onChange={handleInputChange}
                  />
                </div>
              </label>

              <Errors errors={errors.name} />
            </div>

            <div className={form.item}>
              <label>
                <div className={form.label}>
                  Фамилия
                </div>

                <div className={form.input}>
                  <input
                    type="text"
                    value={values.sname}
                    name="sname"
                    onChange={handleInputChange}
                  />
                </div>
              </label>

              <Errors errors={errors.sname} />
            </div>

            <div className={form.item}>
              <label>
                <div className={form.label}>
                  Телефон
                </div>

                <div className={form.input}>
                  <input
                    type="text"
                    value={values.phone}
                    name="phone"
                    onChange={handleInputChange}
                  />
                </div>
              </label>

              <Errors errors={errors.phone} />
            </div>

            <div className={classNames(form.submit, styles.submit)}>
              <input
                type="submit"
                value={pending ? 'Сохраняем данные...' : 'Сменить данные'}
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
