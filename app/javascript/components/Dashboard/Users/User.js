import React, { useEffect, useState } from 'react'
import PropTypes from 'prop-types'
import { deserialize } from 'jsonapi-deserializer'
import axios from 'axios'

import { path } from '../../Routes'

import Orders from '../../Accounts/Show/Orders'
import Refund from '../Refund/Refund'

import styles from './User.module.css'
import page from '../../Page.module.css'

User.propTypes = {
  user: PropTypes.object.isRequired,
  locale: PropTypes.string.isRequired
}

export default function User ({ user: userJSON, locale }) {
  const user = deserialize(userJSON)

  const [orders, setOrders] = useState()
  const [refunds, setRefunds] = useState()

  useEffect(() => {
    const _loadAsyncData = async () => {
      const { data } = await axios.get(path('dashboard_user_path', { id: user.id, format: 'json' }))

      setOrders(data.orders)
      setRefunds(data.refunds)
    }

    _loadAsyncData()
  }, [])

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
              {user.sname}
            </dd>

            <dt>
              Телефон
            </dt>

            <dd>
              {user.phone}
            </dd>

            <dt>
              {user.addresses.length > 1 ? 'Адреса' : 'Адрес'}
            </dt>

            <dd>
              {user.addresses.map((address, i) =>
                <dd key={i}>
                  {address.country + (address.country ? ', ' : '')}
                  {address.city + (address.city ? ', ' : '')}
                  {address.street + (address.street ? ', ' : '')}
                  {'д. ' + address.house + (address.house ? ', ' : '')}
                  {'кв. ' + address.appartment}
                </dd>
              )}
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
