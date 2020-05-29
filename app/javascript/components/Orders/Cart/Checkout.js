import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

import { useI18n } from '../../I18n'
import Price from '../../Variants/Price'

import styles from './Checkout.module.css'
import buttons from '../../Buttons.module.css'

Checkout.propTypes = {
  order: PropTypes.object.isRequired,
  locale: PropTypes.string.isRequired,
  setCheckout: PropTypes.func.isRequired
}

export default function Checkout ({ locale, setCheckout, order }) {
  const I18n = useI18n(locale)

  return (
    <div className={styles.root}>
      <h2>
        {I18n.t('order.cart.checkout.title')}
      </h2>

      <dl className={styles.dl}>
        <dt>
          {I18n.t('order.cart.checkout.variants')}
        </dt>

        <dd className={styles.price}>
          <Price sell={parseFloat(order.amount_calc)} />
        </dd>

        <dt>
          {I18n.t('order.cart.checkout.delivery.russia.title')}
        </dt>

        <dd>
          {I18n.t('order.cart.checkout.delivery.russia.value')}
        </dd>

        <dt>
          {I18n.t('order.cart.checkout.delivery.international.title')}
        </dt>

        <dd>
          {I18n.t('order.cart.checkout.delivery.international.value')}
        </dd>
      </dl>

      <div className={styles.checkout}>
        <button
          className={classNames(buttons.main)}
          disabled={!order['purchasable?']}
          onClick={() => setCheckout(true)}
        >
          {I18n.t('order.cart.checkout.submit')}
        </button>

        {!order['purchasable?'] &&
          <div className={styles.notAvailable}>
            {I18n.t('orders.cart.checkout.notAvailable')}
          </div>
        }
      </div>
    </div>
  )
}
