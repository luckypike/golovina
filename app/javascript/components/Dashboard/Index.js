import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

import { path } from '../Routes'
import { useI18n } from '../I18n'

import Nav from './Nav'
import Order from './Order'

import page from '../Page.module.css'
import styles from './Index.module.css'

Index.propTypes = {
  locale: PropTypes.string.isRequired
}

export default function Index ({ locale }) {
  const I18n = useI18n(locale)

  const [orders, setOrders] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const { data } = await axios.get(path('dashboard_path', { format: 'json' }))

      setOrders(data.orders)
    }

    _fetch()
  }, [])

  return (
    <div className={page.gray}>
      <div className={styles.root}>
        <Nav locale={locale} />

        <div className={page.title}>
          <h1>{I18n.t('dashboard.index.title')}</h1>
        </div>

        {orders && orders.map(order =>
          <Order
            key={order.id}
            order={order}
            locale={locale}
          />
        )}
      </div>
    </div>
  )
}
