import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import dayjs from 'dayjs'
import 'dayjs/locale/ru'
import 'dayjs/locale/en'

import { useI18n } from '../../I18n'
import Price, { currency } from '../../Variants/Price'

import styles from './Orders.module.css'

Orders.propTypes = {
  orders: PropTypes.array,
  cart: PropTypes.object,
  locale: PropTypes.string.isRequired
}

export default function Orders ({ orders, locale, cart }) {
  const I18n = useI18n(locale)

  useEffect(() => {
    dayjs.locale(locale)
  }, [])

  return (
    <div>
      <h2>
        {I18n.t('accounts.show.orders')}
      </h2>

      {cart &&
        <div className={styles.cart}>
          <div className={styles.number}>
            {I18n.t('order.number', { number: cart.number })}
          </div>

          <div>
            Ожидание ответа от банка
          </div>
        </div>
      }

      {orders &&
        <div>
          {orders.map(order =>
            <Order
              key={order.id}
              order={order}
              locale={locale}
            />
          )}

          {orders.length === 0 && 'Вы пока ничего не успели купить в нашем магазине'}
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
          {I18n.t('order.quantity', { count: order.quantity, amount: currency(parseFloat(order.amount)) })}
        </div>

        <svg viewBox="0 0 10 20" className={styles.arr}>
          <polyline points="1 8 5 12 9 8" />
        </svg>
      </div>

      {active &&
        <div className={styles.details}>
          {order.delivery &&
            <div className={styles.address}>
              <Address order={order} locale={locale} />
            </div>
          }

          <div>
            <Items items={order.items} locale={locale} />
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

Items.propTypes = {
  items: PropTypes.array.isRequired,
  locale: PropTypes.string.isRequired
}

function Items ({ items, locale }) {
  const I18n = useI18n(locale)

  return (
    <div className={styles.items}>
      {items.map(item =>
        <div className={styles.item} key={item.id}>
          <div className={styles.image}>
            {item.variant.images.length > 0 &&
              <img src={item.variant.images[0].thumb} />
            }
          </div>

          <div className={styles.itemDetails}>
            <div className={styles.title}>
              {item.variant.title}
            </div>

            <div className={styles.price}>
              <Price sell={parseFloat(item.variant.price_sell)} origin={parseFloat(item.variant.price)} />
            </div>

            <div className={styles.color}>
              {I18n.t('order.color')}: {item.variant.color.title}
            </div>

            {item.size &&
              <div className={styles.size}>
                {I18n.t('order.size')}: {item.size.title}
              </div>
            }

            <div className={styles.quantity}>
              {I18n.t('order.amount')}: {item.quantity}
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
