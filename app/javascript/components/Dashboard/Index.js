import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

import { path } from '../Routes'
import { I18nContext, useI18n } from '../I18n'

import Nav from './Nav'
import Order from './Order'

import page from '../Page.module.css'
import styles from './Index.module.css'
import buttons from '../Buttons.module.css'

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

  const handlePrint = () => {
    window.print()
  }

  return (
    <I18nContext.Provider value={I18n}>
      <div className={page.gray}>
        <div className={styles.root}>
          <Nav locale={locale} />

          <div className={page.title}>
            <h1>{I18n.t('dashboard.index.title')}</h1>
          </div>

          <div className={styles.print}>
            <button className={buttons.main} onClick={handlePrint}>Напечатать</button>
          </div>

          {orders && orders.map(order =>
            <Order
              key={order.id}
              order={order}
              locale={locale}
              delivery={true}
            />
          )}
        </div>
      </div>
    </I18nContext.Provider>
  )
}
