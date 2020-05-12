import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import axios from 'axios'

import { useI18n } from '../../I18n'
import { path } from '../../Routes'

import styles from './Items.module.css'

Items.propTypes = {
  items: PropTypes.array,
  locale: PropTypes.string.isRequired,
  _fetch: PropTypes.func.isRequired,
  checkout: PropTypes.bool.isRequired
}

export default function Items ({ items, checkout, locale, _fetch }) {
  const I18n = useI18n(locale)

  const handleDestroy = async (e, item) => {
    e.preventDefault()

    const { data } = await axios.delete(
      path('order_item_path', { id: item.id, format: 'json' })
    )

    _fetch()
  }

  return (
    <div className={styles.root}>
      {items && items.map(item =>
        <div className={styles.item} key={item.id}>
          <div className={styles.image}>
            {item.variant.images.length > 0 &&
              <img src={item.variant.images[0].thumb} />
            }
          </div>

          <div className={styles.data}>
            <div className={styles.title}>
              <a href={path('catalog_variant_path', { slug: item.variant.category.slug, id: item.variant.id })}>
                {item.variant.title}
              </a>
            </div>

            <div className={styles.price}>
              {/* <Price sell={parseFloat(cart.variant.price_sell)} origin={parseFloat(cart.variant.price)} /> */}
            </div>

            <div className={styles.color}>
              {I18n.t('order.cart.color')}: {item.variant.color.title}
            </div>

            <div className={styles.size}>
              {I18n.t('order.cart.size')}: {item.size.title}
            </div>

            <div className={classNames(styles.quantity)}>
              {I18n.t('order.cart.quantity')}: {item.quantity}
            </div>

            {!checkout &&
              <div className={styles.destroy}>
                <span onClick={e => handleDestroy(e, item)}>
                  {I18n.t('order.cart.delete')}
                </span>
              </div>
            }
          </div>
        </div>
      )}
    </div>
  )
}
