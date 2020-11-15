import React from 'react'
import PropTypes from 'prop-types'
import { deserialize } from 'jsonapi-deserializer'
import cn from 'classnames'
import axios from 'axios'

import { path } from '../Routes'
import { I18nContext, useI18n } from '../I18n'
import { useForm, Errors } from '../Form'
import { currency } from '../Variants/Price'

import page from '../Page'

import Logo from '!svg-react-loader?!../../images/golovina.svg'

import styles from './Index.module.css'
import form from '../Form.module.css'
import buttons from '../Buttons.module.css'

Index.propTypes = {
  discounts: PropTypes.array,
  locale: PropTypes.string.isRequired
}

export default function Index ({ locale, discounts, user: userJSON }) {
  const I18n = useI18n(locale)
  const user = deserialize(userJSON)

  const {
    values,
    setValues,
    // saved,
    setSaved,
    handleInputChange,
    errors,
    pending,
    setErrors,
    onSubmit,
    cancelToken
  } = useForm({
    discount: '',
    email: '',
    user_attributes: {
      name: '',
      sname: '',
      phone: '',
      email: ''
    }
  })

  const handleUserInputChange = ({ target: { name, value } }) => {
    setValues({
      ...values,
      user_attributes: {
        ...values.user_attributes,
        [name]: value
      }
    })
  }

  const handleSubmit = async (e) => {
    e.preventDefault()

    try {
      const { data } = await axios.post(
        path('certs_path', { format: 'json' }),
        { cert: values },
        { cancelToken: cancelToken.current.token }
      )

      console.log(data)
    } catch (error) {
      setErrors(error.response.data)
    }
  }

  return (
    <I18nContext.Provider value={I18n}>
      <div className={page.root}>
        <div className={page.title}>
          <h1>
            {I18n.t('certs.index.title')}
          </h1>
        </div>

        {values.discount === '' && (
          <div className={styles.certs}>
            {discounts.map(discount =>
              <div key={discount} className={styles.cert}>
                <div className={styles.card}>
                  <div className={styles.logo}>
                    <Logo />
                  </div>

                  <div className={styles.amount}>
                    {currency(discount)}
                  </div>

                  <div className={styles.buy}>
                    <button className={buttons.main} onClick={() => setValues({ ...values, discount })}>
                      Купить
                    </button>
                  </div>
                </div>
              </div>
            )}
          </div>
        )}

        {values.discount !== '' && (
          <div>
            <form className={cn(form.root, styles.form)} onSubmit={onSubmit(handleSubmit)}>
              <h2>
                {I18n.t('certs.index.user')}
              </h2>

              <div className={form.el}>
                <label>
                  <div className={form.label}>
                    {I18n.t('user.name')}
                  </div>
                </label>

                <div className={form.input}>
                  <input type='text' name='name' value={values.user_attributes.name} onChange={handleUserInputChange} />
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
                  <input type='text' name='sname' value={values.user_attributes.sname} onChange={handleUserInputChange} />
                </div>

                <Errors errors={errors['user.sname']} />
              </div>

              <div className={form.el}>
                <label>
                  <div className={form.label}>
                    {I18n.t('user.phone')}
                  </div>
                </label>

                <div className={form.input}>
                  <input type='text' name='phone' value={values.user_attributes.phone} onChange={handleUserInputChange} />
                </div>

                <Errors errors={errors['user.phone']} />
              </div>

              <div className={form.el}>
                <label>
                  <div className={form.label}>
                    {I18n.t('user.email')}
                  </div>
                </label>

                <div className={form.input}>
                  <input type='text' name='email' value={values.user_attributes.email} onChange={handleUserInputChange} />
                </div>

                <Errors errors={errors['user.email']} />
              </div>

              <div className={cn(form.submit, styles.submit)}>
                <input
                  type='submit'
                  value={pending ? I18n.t('order.cart.submitted') : I18n.t('order.cart.submit')}
                  className={cn(buttons.main, buttons.big, { [buttons.pending]: pending })}
                  disabled={pending}
                />
              </div>
            </form>
          </div>
        )}
      </div>
    </I18nContext.Provider>
  )
}
