import React from 'react'
import PropTypes from 'prop-types'
// import classNames from 'classnames'

import { useI18n } from '../../I18n'
import Price from '../../Variants/Price'

import styles from './Total.module.css'

Total.propTypes = {
  order: PropTypes.object.isRequired,
  values: PropTypes.object.isRequired,
  delivery_cities: PropTypes.array.isRequired,
  locale: PropTypes.string.isRequired
}

export default function Total ({ order, locale, delivery_cities: deliveryCities, values }) {
  const I18n = useI18n(locale)

  const isRussia = () => values.delivery === 'russia'
  const isInternational = () => values.delivery === 'international'

  let amountDelivery = false

  if (isRussia() && values.delivery_city_id && values.delivery_option) {
    // amountDelivery = order.amount_without_delivery_calc < 15000 ? deliveryCities.find(c => c.id === values.delivery_city_id)[values.delivery_option] : 0
    amountDelivery = deliveryCities.find(c => c.id === values.delivery_city_id)[values.delivery_option]
  }

  if (isInternational()) {
    amountDelivery = 2800
  }

  return (
    <div className={styles.result}>
      <dl className={styles.dl}>
        <dt>
          {I18n.t('order.cart.checkout.variants')}
        </dt>

        <dd className={styles.price}>
          <Price sell={parseFloat(order.amount_without_delivery_calc)} />
        </dd>

        {amountDelivery !== false &&
          <>
            <dt>
              {I18n.t(`order.cart.checkout.delivery.${values.delivery}.title`)}
            </dt>

            <dd className={styles.price}>
              {amountDelivery > 0 &&
                <Price sell={parseFloat(amountDelivery)} />
              }

              {amountDelivery === 0 && I18n.t('order.cart.checkout.delivery.free')}
            </dd>

            <dt>
              {I18n.t('order.cart.checkout.total')}
            </dt>

            <dd className={styles.price}>
              <Price sell={parseFloat(order.amount_without_delivery_calc) + parseFloat(amountDelivery)} />
            </dd>
          </>
        }
      </dl>
    </div>
  )
}
