import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'
import classNames from 'classnames'
import InputMask from 'react-input-mask'
import PubSub from 'pubsub-js'
import Select from 'react-select'

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
  const [dictionaries, setDictionaries] = useState()
  const [price, setPrice] = useState()
  const [city, setCity] = useState()

  const _fetch = async () => {
    const { data } = await axios.get(path('cart_path', { format: 'json' }))

    setValues(data.values)
    setDictionaries(data.dictionaries)
    setCarts(data.carts)
    setPrice(data.price)
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
        order: {
          ...values,
          delivery_city_id: city ? city.id : null
        },
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

  const isPickup = () => values.delivery === 'pickup'
  const isRussia = () => values.delivery === 'russia'
  const isInternational = () => values.delivery === 'international'

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

              <h2>
                Выберите способ получения
              </h2>

              <label className={form.el}>
                <div className={styles.delivery}>
                  <div
                    className={classNames(
                      styles.deliveryItem,
                      { [styles.active]: isPickup() }
                    )}
                    onClick={() => {
                      setValues({
                        ...values,
                        delivery: 'pickup',
                        delivery_option: null
                      })
                      setCity()
                    }}
                  >
                    <strong>
                      Самостоятельно
                    </strong>
                    <div className={styles.deliveryItemDesc}>
                      Москва, Большая Никитская, 21/18 с4
                    </div>
                  </div>

                  <div
                    className={classNames(
                      styles.deliveryItem,
                      { [styles.active]: isRussia() }
                    )}
                    onClick={() => setValues({ ...values, delivery: 'russia' })}
                  >
                    <strong>
                      Доставка по России
                    </strong>
                    <div className={styles.deliveryItemDesc}>
                      Более 500 городов до двери или до точки выдачи от 265 ₽
                    </div>
                  </div>

                  <div
                    className={classNames(
                      styles.deliveryItem,
                      { [styles.active]: isInternational() }
                    )}
                    onClick={() => setValues({ ...values, delivery: 'international' })}
                  >
                    <strong>
                      Международная доставка
                    </strong>
                    <div className={styles.deliveryItemDesc}>
                      Доставка за пределы России от 2500 ₽
                    </div>
                  </div>
                </div>
              </label>

              {dictionaries && isRussia() &&
                <div className={form.el}>
                  <label>
                    <div className={form.label}>
                      {I18n.t('order.delivery_city')}
                    </div>
                  </label>

                  <div className={form.input}>
                    <Select
                      placeholder={I18n.t('order.choose_delivery_city')}
                      noOptionsMessage={() => null}
                      classNamePrefix="react-select"
                      isClearable={true}
                      value={values.delivery_city_id}
                      getOptionLabel={option => option.title}
                      getOptionValue={option => option.id}
                      onChange={selectedCity => {
                        if (selectedCity) {
                          setCity(selectedCity)
                          setValues({ ...values, delivery_option: (selectedCity.door ? 'door' : 'storage') })
                        } else {
                          setCity()
                          setValues({ ...values, delivery_option: null })
                        }
                      }}
                      options={dictionaries.delivery_cities}
                    />
                  </div>

                  <p className={styles.noCity}>
                    Если вы не нашли нужный город свяжитесь с нами, чтобы обсудить возможные варианты доставки. Можете позвонить по номеру телефона <a href="tel:+79857145558">+7 985 714-55-58</a> или выбрать опцию самостоятельного получения заказа, чтобы решить этот вопрос позже.
                  </p>

                  {city &&
                    <div className={form.radio}>
                      {city.door &&
                        <label>
                          <input
                            type="radio"
                            name="delivery_option"
                            checked={values.delivery_option === 'door'}
                            onChange={() => setValues({ ...values, delivery_option: 'door' })}
                          />
                          Доставка до двери ({city.door_days} дн.): {city.door} ₽
                        </label>
                      }

                      <label>
                        <input
                          type="radio"
                          name="delivery_option"
                          checked={values.delivery_option === 'storage'}
                          onChange={() => setValues({ ...values, delivery_option: 'storage' })}
                        />
                        Доставка до точки выдачи ({city.storage_days}): {city.storage} ₽
                      </label>
                    </div>
                  }

                  <Errors errors={errors.delivery_city} />
                </div>
              }

              {((isRussia() && values.delivery_option === 'door') || isInternational()) &&
                <div className={form.el}>
                  <label>
                    <div className={form.label}>
                      {I18n.t('order.address')}
                    </div>
                  </label>

                  <div className={form.input}>
                    <textarea type="text" name="address" value={values.address} onChange={handleInputChange} />
                  </div>

                  <Errors errors={errors.address} />
                </div>
              }

              <h2>
                Заполните ваши данные
              </h2>

              <User
                errors={errors}
                userValues={values.user_attributes}
                locale={locale}
                onValuesChange={
                  userValues => setValues({ ...values, user_attributes: userValues })
                }
              />

              {((isRussia() && values.delivery_option) || isInternational() || isPickup()) && price &&
                <h2>
                  Итоговая стоимость
                  <div className={styles.price}>
                    <Price sell={parseFloat(price.sell) + (isInternational() ? 2500 : (isRussia() ? city[values.delivery_option] : 0))} />
                  </div>
                </h2>
              }

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
          <InputMask type="tel" name="phone" mask="+9 999 999 99 99" maskChar=" " value={values.phone} onChange={handleInputChange} />
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
