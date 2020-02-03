import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'
import classNames from 'classnames'
import PubSub from 'pubsub-js'
import Select from 'react-select'
import PhoneInput from 'react-phone-input-2'

import { path } from '../Routes'
import { useI18n } from '../I18n'
import Price from '../Variants/Price'
import { Errors } from '../Form'

import Auth from '../Sessions/Auth'

import page from '../Page'

import styles from './Index.module.css'
import form from '../Form.module.css'
import buttons from '../Buttons.module.css'

Index.propTypes = {
  user: PropTypes.object,
  locale: PropTypes.string,
  appleid: PropTypes.object.isRequired
}

export default function Index ({ locale, appleid, user }) {
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
  const isPromo = () => price.promo && parseFloat(price.sell) >= price.promo

  return (
    <div className={page.gray}>
      <div className={page.title}>
        <h1>{I18n.t('cart.title')}</h1>
      </div>

      {carts && carts.length < 1 &&
        <div>
          {I18n.t('cart.empty')}
        </div>
      }

      {carts && carts.length > 0 &&
        <div className={styles.root}>
          <div className={styles.carts}>
            {price &&
              <div className={styles.amount}>
                <div className={styles.sum}>{I18n.t('cart.sum')}:</div>
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
                  {I18n.t('cart.color')}: {cart.color.title}
                </div>

                <div className={styles.size}>
                  {I18n.t('cart.size')}: {cart.size.title}
                </div>

                <div className={classNames(styles.quantity, { [styles.unavailable]: !cart.available })}>
                  {I18n.t('cart.quantity')}: {cart.quantity} {!cart.available ? ` (${I18n.t('cart.available')}: ${cart.quantity_available})` : null}
                </div>

                <div className={styles.destroy} onClick={() => handleDestroy(cart)}>
                  {I18n.t('cart.delete')}
                </div>
              </div>
            )}
          </div>

          <div className={styles.checkout}>
            <form className={classNames(form.root, styles.form)} onSubmit={handleSubmit}>

              <h2>
                {I18n.t('cart.shipping.title')}
              </h2>

              <label className={form.el}>
                <div className={styles.delivery}>
                  <>
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
                        {I18n.t('cart.shipping.store.title')}
                      </strong>
                      <div className={styles.deliveryItemDesc}>
                        {I18n.t('cart.shipping.store.desc')}
                      </div>
                    </div>

                    {I18n.locale === 'ru' &&
                      <div
                        className={classNames(
                          styles.deliveryItem,
                          { [styles.active]: isRussia() }
                        )}
                        onClick={() => setValues({ ...values, delivery: 'russia' })}
                      >
                        <strong>
                          {I18n.t('cart.shipping.russia.title')}
                        </strong>
                        <div className={styles.deliveryItemDesc}>
                          {I18n.t('cart.shipping.russia.desc')}
                          <div className={styles.promo}>
                            {price && isPromo() &&
                              I18n.t('cart.shipping.russia.promo')
                            }
                          </div>
                        </div>
                      </div>
                    }
                  </>

                  <div
                    className={classNames(
                      styles.deliveryItem,
                      { [styles.active]: isInternational() }
                    )}
                    onClick={() => setValues({ ...values, delivery: 'international' })}
                  >
                    <strong>
                      {I18n.t('cart.shipping.world.title')}
                    </strong>
                    <div className={styles.deliveryItemDesc}>
                      {I18n.t('cart.shipping.world.desc')}
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
                          Доставка до двери ({city.door_days} дн.): {isPromo() ? 'бесплатно' : `${city.door} ₽`}
                        </label>
                      }

                      {city.storage &&
                        <label>
                          <input
                            type="radio"
                            name="delivery_option"
                            checked={values.delivery_option === 'storage'}
                            onChange={() => setValues({ ...values, delivery_option: 'storage' })}
                          />
                          Доставка до точки выдачи ({city.storage_days}): {isPromo() ? 'бесплатно' : `${city.storage} ₽`}
                        </label>
                      }
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

              {(!user || user['guest?']) &&
                <>
                  <div className={styles.appleid}>
                    <Auth appleid={appleid} from="cart" text={I18n.t('session.appleid')} />

                    <p className={styles.appledesc}>
                      {I18n.t('cart.appledesc')}
                    </p>
                  </div>

                  <div className={styles.sep}>{I18n.t('cart.or')}</div>
                </>
              }

              <h2>
                {I18n.t('cart.shipping.data')}
              </h2>

              <User
                errors={errors}
                userValues={values.user_attributes}
                locale={locale}
                onValuesChange={
                  userValues => setValues({ ...values, user_attributes: userValues })
                }
              />

              <div className={form.el}>
                <label>
                  <div className={form.label}>
                    {I18n.t('user.phone')}
                  </div>
                </label>

                <PhoneInput
                  type="tel" name="phone"
                  placeholder="+7 999 111-11-11"
                  value={values.phone}
                  disableDropdown={true}
                  buttonClass={styles.countries}
                  containerClass={form.input}
                  onChange={phone => setValues({ ...values, phone })} />

                <Errors errors={errors.phone} />
              </div>

              {((isRussia() && values.delivery_option) || isInternational() || isPickup()) && price &&
                <h2>
                  {I18n.t('cart.total')}
                  <div className={styles.price}>
                    <Price sell={parseFloat(price.sell) + (isInternational() ? 2500 : (isRussia() && !isPromo() ? city[values.delivery_option] : 0))} />
                  </div>
                </h2>
              }

              {carts.filter(cart => !cart.available).length === 0 &&
                <div className={form.submit}>
                  <input type="submit" value={I18n.t('cart.checkout')} className={buttons.main} />

                  <Errors errors={errors.delivery} />
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
