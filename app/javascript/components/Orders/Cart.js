import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'
import classNames from 'classnames'
// import Select from 'react-select'
import { deserialize } from 'jsonapi-deserializer'

import Items from './Cart/Items'
import User from './Cart/User'
import Address from './Cart/Address'
import UserAddresses from './Cart/UserAddresses'
import Login from './Cart/Login'
import Checkout from './Cart/Checkout'
import Total from './Cart/Total'
import Discount from './Cart/Discount'

import { path } from '../Routes'
import { useI18n } from '../I18n'
import { useForm, Errors } from '../Form'

import styles from './Cart.module.css'
import page from '../Page.module.css'
import form from '../Form.module.css'
import buttons from '../Buttons.module.css'

Cart.propTypes = {
  locale: PropTypes.string,
  user: PropTypes.object,
  appleid: PropTypes.object.isRequired
}

export default function Cart ({ appleid, locale, user: userJSON }) {
  const I18n = useI18n(locale)
  const user = deserialize(userJSON)

  const [checkout, setCheckout] = useState(false)
  const [loading, setLoading] = useState(true)
  const [guest, setGuest] = useState(false)
  const [newAddress, setNewAddress] = useState(false)
  const [order, setOrder] = useState()
  const [dictionaries, setDictionaries] = useState()

  const _fetch = async () => {
    const { data } = await axios.get(path('cart_path', { format: 'json' }))

    setOrder(data.order)
    setValues(data.values)
    setDictionaries(data.dictionaries)
    setLoading(false)
  }

  useEffect(() => {
    _fetch()
  }, [])

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
  } = useForm()

  const handleSubmit = async e => {
    e.preventDefault()

    await axios.patch(
      path('checkout_order_path', { id: order.id, format: 'json' }),
      { order: values },
      { cancelToken: cancelToken.current.token }
    ).then(res => {
      if (res.data['purchasable?']) {
        if (res.headers.location && window) window.location = res.headers.location
      } else {
        _fetch()
      }
      setSaved(true)
    }).catch(error => {
      setErrors(error.response.data)
    })
  }

  const isPickup = () => values.delivery === 'pickup'
  const isRussia = () => values.delivery === 'russia'
  const isInternational = () => values.delivery === 'international'

  const isStep1 = () => !checkout
  const isStep2 = () => !isStep1() && (!guest && user.guest)
  const isStep3 = () => !isStep1() && !isStep2() && (guest || user.common)

  const haveUserAddresses = () => dictionaries && dictionaries.user_addresses.length > 0

  if (loading) return null

  return (
    <div className={page.gray}>
      <div className={page.title}>
        <h1>{I18n.t('order.cart.title')}</h1>
      </div>

      {(!order || order.items.length < 1) &&
        <div className={styles.empty}>
          {I18n.t('order.cart.empty')}
        </div>
      }

      {order && values && dictionaries && order.items.length > 0 &&
        <div className={styles.root}>
          <div className={styles.items}>
            <Items
              items={order.items}
              locale={locale}
              checkout={checkout}
              setCheckout={setCheckout}
              _fetch={_fetch}
            />

            <Discount order={order} locale={locale} />
          </div>

          <div className={styles.checkout}>
            {isStep1() &&
              <div className={styles.checkout}>
                <Checkout
                  setCheckout={setCheckout}
                  locale={locale}
                  order={order}
                />
              </div>
            }

            {isStep2() &&
              <div>
                <Login setGuest={setGuest} appleid={appleid} locale={locale} />
              </div>
            }

            {isStep3() &&
              <form className={classNames(form.root, styles.form)} onSubmit={onSubmit(handleSubmit)}>
                <div className={classNames(styles.step, { [styles.inactive]: !isStep3() || pending })}>
                  <div className={styles.overlay} />

                  <h2>
                    {I18n.t('order.cart.shipping.title')}
                  </h2>

                  <div className={form.el}>
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
                            delivery_option: null,
                            delivery_city_id: null,
                            user_address_id: ''
                          })
                        }}
                      >
                        <strong>
                          {I18n.t('order.cart.shipping.store.title')}
                        </strong>

                        <div className={styles.deliveryItemDesc}>
                          {I18n.t('order.cart.shipping.store.desc')}
                        </div>
                      </div>

                      {haveUserAddresses() && !newAddress &&
                        <UserAddresses
                          values={values}
                          setValues={setValues}
                          addresses={dictionaries.user_addresses}
                          cities={dictionaries.delivery_cities}
                          setNewAddress={setNewAddress}
                          locale={locale}
                        />
                      }

                      {(newAddress || !haveUserAddresses()) &&
                        <>
                          {I18n.locale === 'ru' &&
                            <div
                              className={classNames(
                                styles.deliveryItem,
                                { [styles.active]: isRussia() }
                              )}
                              onClick={() => setValues({ ...values, delivery: 'russia' })}
                            >
                              <strong>
                                {I18n.t('order.cart.shipping.russia.title')}
                              </strong>

                              <div className={styles.deliveryItemDesc}>
                                {I18n.t('order.cart.shipping.russia.desc')}
                              </div>
                            </div>
                          }
                          <div
                            className={classNames(
                              styles.deliveryItem,
                              { [styles.active]: isInternational() }
                            )}
                            onClick={() => setValues({ ...values, delivery: 'international', delivery_option: null, delivery_city_id: null })}
                          >
                            <strong>
                              {I18n.t('order.cart.shipping.world.title')}
                            </strong>

                            <div className={styles.deliveryItemDesc}>
                              {I18n.t('order.cart.shipping.world.desc')}
                            </div>
                          </div>
                        </>
                      }
                    </div>

                    <Errors errors={errors.delivery} />
                  </div>

                  <Address
                    errors={errors}
                    values={values}
                    handleInputChange={handleInputChange}
                    dictionaries={dictionaries}
                    setValues={setValues}
                    locale={locale}
                  />
                </div>

                <div className={classNames(styles.step, { [styles.inactive]: !isStep3() || pending })}>
                  <div className={styles.overlay} />

                  <h2>
                    {I18n.t('order.cart.shipping.data')}
                  </h2>

                  <User
                    errors={errors}
                    userValues={values.user_attributes}
                    locale={locale}
                    onValuesChange={
                      userValues => setValues({ ...values, user_attributes: userValues })
                    }
                  />

                  <div className={form.item}>
                    <label>
                      <div className={form.label}>
                        {I18n.t('order.cart.comment')}
                      </div>

                      <div className={form.input}>
                        <textarea
                          value={values.comment}
                          name="comment"
                          onChange={handleInputChange}
                        />
                      </div>
                    </label>

                    <Errors errors={errors.comment} />
                  </div>

                  {!order['purchasable?'] &&
                    <div className={styles.notAvailable}>
                      {I18n.t('orders.cart.checkout.notAvailable')}
                    </div>
                  }

                  <Total order={order} locale={locale} values={values} delivery_cities={dictionaries.delivery_cities} />

                  <div className={classNames(form.submit, styles.submit)}>
                    <input
                      type="submit"
                      value={pending ? I18n.t('order.cart.submitted') : I18n.t('order.cart.submit')}
                      className={classNames(buttons.main, buttons.big, { [buttons.pending]: pending })}
                      disabled={pending || !order['purchasable?']}
                    />
                  </div>
                </div>
              </form>
            }
          </div>
        </div>
      }
    </div>
  )
}
