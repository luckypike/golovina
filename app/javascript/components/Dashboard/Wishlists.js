import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'
import dayjs from 'dayjs'
import 'dayjs/locale/ru'
import 'dayjs/locale/en'

import { path } from '../Routes'
import { useI18n } from '../I18n'

// import Nav from './Nav'
// import Refund from './Refund/Refund'

import page from '../Page.module.css'
import styles from './Wishlists.module.css'

Refunds.propTypes = {
  locale: PropTypes.string.isRequired
}

export default function Refunds ({ locale }) {
  const I18n = useI18n(locale)

  dayjs.locale(locale)

  const [wishlists, setWishlists] = useState()
  // const [active, setActive] = useState(false)

  useEffect(() => {
    const _fetch = async () => {
      const { data } = await axios.get(path('dashboard_wishlists_path', { format: 'json' }))

      setWishlists(data.wishlists)
    }

    _fetch()
  }, [])

  return (
    <div className={page.gray}>
      <div className={styles.root}>
        <div className={page.title}>
          <h1>{I18n.t('dashboard.wishlists.title')}</h1>
        </div>

        {wishlists && wishlists.map(wishlist =>
          <div key={wishlist.user.id} className={styles.wishlist}>
            <div className={styles.header}>
              <div className={styles.date}>
                {dayjs(wishlist.wishlists[0].created_at).format('D MMMM YYYY H:mm')}
              </div>

              <div className={styles.what}>
                {I18n.t('dashboard.wishlists.count', { count: wishlist.wishlists.length })}
              </div>
            </div>

            <div className={styles.details}>
              {wishlist.user.state === 'common' &&
                <div className={styles.user}>
                  <strong>
                    {wishlist.user.title}
                  </strong>
                  <br />
                  Телефон: {wishlist.user.phone}
                  <br />
                  Почта: {wishlist.user.email}
                </div>
              }

              <div>
                <Items items={wishlist.wishlists} locale={locale} />
              </div>
            </div>
          </div>
        )}
      </div>
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

            <div className={styles.color}>
              {I18n.t('order.color')}: {item.variant.color.title}
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
