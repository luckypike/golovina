import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import dayjs from 'dayjs'
import 'dayjs/locale/ru'
import 'dayjs/locale/en'

import { useI18n } from '../../I18n'
// import Price, { currency } from '../../Variants/Price'

import styles from './Orders.module.css'

Orders.propTypes = {
  orders: PropTypes.array,
  locale: PropTypes.string.isRequired
}

export default function Orders ({ orders, locale }) {
  const I18n = useI18n(locale)

  useEffect(() => {
    dayjs.locale(locale)
  }, [])

  return (
    <div>
      <h2>
        {I18n.t('accounts.show.orders')}
      </h2>

      {orders &&
        <div>
          {orders.map(order =>
            <Order
              key={order.id}
              order={order}
              locale={locale}
            />
          )}
        </div>
      }
    </div>
  )
}

Order.propTypes = {
  order: PropTypes.object.isRequired,
  locale: PropTypes.string.isRequired
}

function Order ({ order, locale }) {
  const I18n = useI18n(locale)

  const [active, setActive] = useState(false)

  return (
    <div className={classNames(styles.order, { [styles.active]: active })}>
      <div className={styles.header} onClick={() => setActive(!active)}>
        <div className={styles.number}>
          {I18n.t('order.number', { number: order.number })}
        </div>

        <div className={styles.date}>
          {dayjs(order.payed_at).format('D MMMM YYYY H:mm')}
        </div>

        <div className={styles.what}>
          {I18n.t('order.quantity', { count: order.quantity, amount: '999' })}
        </div>

        <svg viewBox="0 0 10 20" className={styles.arr}>
          <polyline points="1 8 5 12 9 8" />
        </svg>
      </div>

      {active &&
        <div className={styles.details}>
          <div className={styles.address}>
            <Address order={order} locale={locale} />
          </div>

          <div>
            Список товаров (доделывается)
          </div>
        </div>
      }
    </div>
  )
}

Address.propTypes = {
  order: PropTypes.object.isRequired,
  locale: PropTypes.string.isRequired
}

function Address ({ order, locale }) {
  const I18n = useI18n(locale)

  const isRussia = () => order.delivery === 'russia'
  const isDoor = () => order.delivery_option === 'door'
  const isInternational = () => order.delivery === 'international'

  return (
    <div>
      <div className={styles.delivery}>
        {I18n.t(`order.delivery.${order.delivery}`)}
      </div>

      {isRussia() &&
        <div>
          {!order.address_old &&
            <>
              {isDoor() &&
                [order.delivery_city.title, order.street, order.house, order.appartment].filter(Boolean).join(', ')
              }

              {!isDoor() &&
                [order.delivery_city.title, I18n.t('order.storage')].filter(Boolean).join(', ')
              }
            </>
          }

          {/* LEGACY */}
          {order.address_old &&
            [order.delivery_city.title, order.address_old].filter(Boolean).join(', ')
          }
        </div>
      }

      {isInternational() &&
        <div>
          {!order.address_old &&
            <>
              {[order.country, order.city, order.street, order.house, order.appartment].filter(Boolean).join(', ')}
            </>
          }

          {/* LEGACY */}
          {order.address_old && order.address_old}
        </div>
      }

    </div>
  )
}
