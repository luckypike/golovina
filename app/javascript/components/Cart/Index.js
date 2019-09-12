import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'
import classNames from 'classnames'
import InputMask from 'react-input-mask'
import PubSub from 'pubsub-js'

import { path } from '../Routes'
import { useI18n } from '../I18n'
import Price from '../Variants/Price'
import { Errors } from '../Form'

import page from '../Page'

import styles from './Index.module.css'
import form from '../Form.module.css'
import buttons from '../Buttons.module.css'

Index.propTypes = {
  locale: PropTypes.string
}

export default function Index ({ locale }) {
  const I18n = useI18n(locale)

  const [send, setSend] = useState(false)
  const [errors, setErrors] = useState({})
  const [carts, setCarts] = useState()
  const [values, setValues] = useState()
  const [price, setPrice] = useState()

  const _fetch = async () => {
    const { data: { values, carts, price } } = await axios.get(path('cart_path', { format: 'json' }))

    setValues(values)
    setCarts(carts)
    setPrice(price)
  }

  useEffect(() => {
    _fetch()
  }, [])

  const handleSubmit = async e => {
    e.preventDefault()

    if (send) {
      return null
    } else {
      setErrors({})
      setSend(true)
    }

    await axios.post(
      path('orders_path'),
      {
        order: values,
        authenticity_token: document.querySelector('[name="csrf-token"]').content
      }
    ).then(({ headers: { location } }) => {
      window.location = location
    }).catch(({ response: { data } }) => {
      setErrors(data)
      setSend(false)
    })
  }

  const handleDestroy = async cart => {
    const { data: { quantity } } = await axios.delete(
      path('cart_destroy_path', { id: cart.id }),
      {
        params: {
          authenticity_token: document.querySelector('[name="csrf-token"]').content
        }
      }
    )

    PubSub.publish('update-cart', quantity)
    _fetch()
  }

  const handleInputChange = ({ target: { name, value } }) => {
    setValues({ ...values, [name]: value })
  }

  return (
    <div className={page.gray}>
      <div className={page.title}>
        <h1>{I18n.t('cart.title')}</h1>
      </div>

      {carts && carts.length < 1 &&
        <div>
          В корзине пока ничего нет :(
        </div>
      }

      {carts && carts.length > 0 &&
        <div className={styles.root}>
          <div className={styles.carts}>
            {price &&
              <div className={styles.amount}>
                <div className={styles.sum}>Сумма заказа:</div>
                <Price sell={parseFloat(price.sell)} origin={parseFloat(price.origin)} />
              </div>
            }

            {carts.map(cart =>
              <div className={styles.cart} key={cart.id}>
                <div className={styles.image}>
                  {cart.variant.images.length > 0 &&
                    <img src={cart.variant.images[0].thumb} />
                  }
                </div>

                <div className={styles.title}>
                  {cart.variant.title}
                </div>

                <div className={styles.price}>
                  <Price sell={parseFloat(cart.variant.price_sell)} origin={parseFloat(cart.variant.price)} />
                </div>

                <div className={styles.color}>
                  Цвет: {cart.color.title}
                </div>

                <div className={styles.size}>
                  Размер: {cart.size.title}
                </div>

                <div className={classNames(styles.quantity, { [styles.unavailable]: !cart.available })}>
                  Количество: {cart.quantity} {!cart.available ? ` (доступно: ${cart.quantity_available})` : null}
                </div>

                <div className={styles.destroy} onClick={() => handleDestroy(cart)}>
                  Удалить из корзины
                </div>
              </div>
            )}
          </div>

          <div className={styles.checkout}>
            <form className={classNames(form.root, styles.form)} onSubmit={handleSubmit}>
              <User
                errors={errors}
                userValues={values.user_attributes}
                locale={locale}
                onValuesChange={
                  userValues => setValues({ ...values, user_attributes: userValues })
                }
              />

              <label className={form.el}>
                <div className={form.label}>
                  Адрес доставки
                </div>

                <div className={form.input}>
                  <textarea type="text" name="address" value={values.address} onChange={handleInputChange} />
                </div>

                {errors.address &&
                  <div className={form.error}>
                    <ul>
                      {errors.address.map((error, i) => <li key={i}>{error}</li>)}
                    </ul>

                  </div>
                }

                <div className={form.hint}>
                  Не заполняйте это поле если планируете забрать заказ самостоятельно.
                </div>
              </label>

              {carts.filter(cart => !cart.available).length === 0 &&
                <div className={form.submit}>
                  <input type="submit" value="Оформить заказ" className={buttons.main} />
                </div>
              }
            </form>
          </div>
        </div>
      }
    </div>
  )
}

User.propTypes = {
  errors: PropTypes.object,
  userValues: PropTypes.object,
  onValuesChange: PropTypes.func,
  locale: PropTypes.string
}

function User ({ errors, userValues, onValuesChange, locale }) {
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
            {I18n.t('user.phone')}
          </div>
        </label>

        <div className={form.input}>
          <InputMask type="text" name="phone" mask="+9 999 999 99 99" maskChar=" " value={values.phone} onChange={handleInputChange} />
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
          <input type="email" name="email" value={values.email} onChange={handleInputChange} />
        </div>

        <Errors errors={errors['user.email']} />
      </div>
    </>
  )
}
