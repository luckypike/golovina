import React, { useEffect, useState } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

import { path } from '../../Routes'

import Orders from '../../Accounts/Show/Orders'
import Refund from '../Refund/Refund'

import styles from './User.module.css'
import page from '../../Page.module.css'

User.propTypes = {
  id: PropTypes.number,
  locale: PropTypes.string.isRequired
}

export default function User ({ id, locale }) {
  const [user, setUser] = useState()
  const [orders, setOrders] = useState()
  const [refunds, setRefunds] = useState()

  useEffect(() => {
    const _loadAsyncData = async () => {
      const { data } = await axios.get(path('dashboard_user_path', { id: id, format: 'json' }))

      setUser(data.user)
      setOrders(data.orders)
      setRefunds(data.refunds)
    }

    _loadAsyncData()
  }, [])

  if (!user) return null

  return (
    <div className={page.gray}>
      <div className={page.title}>
        <h1>Личные кабинет</h1>
      </div>

      <div className={styles.root}>
        <div className={styles.user}>
          <h2>Персональные данные</h2>

          <dl className={styles.dl}>
            <dt>
              Почта
            </dt>

            <dd>
              {user.email}
            </dd>

            <dt>
              Имя
            </dt>

            <dd>
              {user.name}
            </dd>

            <dt>
              Фамилия
            </dt>

            <dd>
              {user.s_name}
            </dd>

            <dt>
              Телефон
            </dt>

            <dd>
              {user.phone}
            </dd>
          </dl>
        </div>

        <div className={styles.orders}>
          <div className={styles.title}>
            Заказы
          </div>

          <Orders orders={orders} locale={locale} />
        </div>

        {refunds && refunds.length > 0 &&
          <div className={styles.refunds}>
            <div className={styles.title}>
              Возвраты
            </div>

            {refunds.map(refund =>
              <Refund refund={refund} locale={locale} key={refund.id} />
            )}
          </div>
        }
      </div>
    </div>
  )
}
