import React, { useState } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import axios from 'axios'
import dayjs from 'dayjs'
import 'dayjs/locale/ru'
import 'dayjs/locale/en'

import Price, { currency } from '../Variants/Price'
import { path } from '../Routes'
import { useI18n } from '../I18n'

import styles from './Order.module.css'
import buttons from '../Buttons.module.css'

Order.propTypes = {
  order: PropTypes.object.isRequired,
  locale: PropTypes.string.isRequired
}

export default function Order ({ order, locale }) {
  const I18n = useI18n(locale)

  const [active, setActive] = useState(false)
  const [hide, setHide] = useState(false)

  dayjs.locale(locale)

  const handleArhiveClick = async e => {
    e.preventDefault()

    axios.post(
      path('archive_order_path', { id: order.id, format: 'json' })
    ).then(res => {
      setHide(true)
    })
  }

  const handleUnarhiveClick = async e => {
    e.preventDefault()

    axios.post(
      path('unarchive_order_path', { id: order.id, format: 'json' })
    ).then(res => {
      setHide(true)
    })
  }

  if (hide) return null

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
          {order.user &&
            <div className={styles.user}>
              <strong>
                {order.user.title}
              </strong>
              <br />
              Телефон: {order.user.phone}
              <br />
              Почта: {order.user.email}
            </div>
          }

          <div className={styles.address}>
            <Address order={order} locale={locale} />
          </div>

          {order.comment &&
            <div className={styles.comment}>
              <strong>
                Комментарий
              </strong>: {order.comment}
            </div>
          }

          <div>
            <Items items={order.items} locale={locale} />
          </div>
        </div>
      }

      {(order.state === 'paid' || order.state === 'archived') &&
        <div className={styles.manage}>
          {/* <div>
            Указать трек номер
          </div> */}

          <div className={styles.state}>
            {order.state === 'paid' &&
              <button className={buttons.main} onClick={handleArhiveClick}>
                В архив
              </button>
            }

            {order.state === 'archived' &&
              <button className={buttons.main} onClick={handleUnarhiveClick}>
                В заказы
              </button>
            }
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
  const isPickup = () => order.delivery === 'pickup'

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

      {order.amount_delivery && !isPickup() &&
        <div>
          {I18n.t('order.delivery.amount')}: {currency(parseFloat(order.amount_delivery))}
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

            <div className={styles.size}>
              {I18n.t('order.size')}: {item.size.title}
            </div>

            <div className={styles.quantity}>
              {I18n.t('order.amount')}: {item.quantity}
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
