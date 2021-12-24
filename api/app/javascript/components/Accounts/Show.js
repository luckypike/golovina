import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import { deserialize } from 'jsonapi-deserializer'
import axios from 'axios'

import User from './Show/User'
import Orders from './Show/Orders'

import { useI18n } from '../I18n'
import { path } from '../Routes'

import styles from './Show.module.css'
import page from '../Page.module.css'

Show.propTypes = {
  user: PropTypes.object.isRequired,
  locale: PropTypes.string.isRequired
}

export default function Show ({ user: userJSON, locale }) {
  const I18n = useI18n(locale)
  const user = deserialize(userJSON)

  const [orders, setOrders] = useState()
  const [cart, setCart] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const { data } = await axios.get(path('account_path', { format: 'json' }))

      setOrders(data.orders)

      if (window.location.hash === '#payed') {
        setCart(data.cart)
      }
    }

    _fetch()
  }, [])

  return (
    <div className={page.gray}>
      <div className={page.title}>
        <h1>{I18n.t('accounts.show.title')}</h1>
      </div>

      <div className={styles.root}>
        <div className={styles.user}>
          <User locale={locale} user={user} />
        </div>

        <div className={styles.orders}>
          <Orders locale={locale} orders={orders} cart={cart} />
        </div>
      </div>
    </div>
  )
}
