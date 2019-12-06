import React, { useState, useEffect } from 'react'
import axios from 'axios'
import classNames from 'classnames'
// import update from 'immutability-helper'

import { path } from '../Routes'
import I18n from '../I18n'
import List from '../Orders/List'

import page from '../Page'

import styles from './Index.module.css'

export default function Index () {
  const _cancelToken = axios.CancelToken.source()
  const TABS = ['paid', 'active', 'archived']

  const [activeTab, setActiveTab] = useState(TABS[0])
  const [orders, setOrders] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const { data } = await axios.get(
        path('orders_path', { format: 'json', query: { state: activeTab } }),
        { cancelToken: _cancelToken.token }
      )

      setOrders(data.orders)
    }

    setOrders()
    _fetch()

    return () => {
      _cancelToken.cancel()
    }
  }, [activeTab])

  const handleOrderChange = id => {
    const newOrders = [...orders].filter(order => order.id !== id)
    setOrders(newOrders)
  }

  return (
    <div className={page.gray}>
      <div className={page.title}>
        <h1>Заказы</h1>
      </div>

      <div className={styles.tabs}>
        {TABS.map(tab =>
          <div key={tab} className={classNames(styles.tab, { [styles.active]: tab === activeTab })} onClick={() => setActiveTab(tab)}>
            {I18n.t(`order.state.${tab}`)}
          </div>
        )}

        <a href={path('refunds_path')} className={styles.tab}>
          {I18n.t(`order.state.refund`)}
        </a>

        <a href={path('carts_path')} className={styles.tab}>
          {I18n.t(`order.state.cart`)}
        </a>

        <a href={path('subscribers_path')} className={styles.tab}>
          {I18n.t(`order.state.subscribers`)}
        </a>
      </div>

      {orders &&
        <div className={styles.orders}>
          {orders.length === 0 &&
            <div className={styles.empty}>Пока у вас нет ни одного заказа.</div>
          }

          {orders.length > 0 &&
            <List orders={orders} onOrderChange={handleOrderChange} />
          }
        </div>
      }

      {!orders &&
        <div className={styles.loading}>Загрузка заказов...</div>
      }
    </div>
  )
}
