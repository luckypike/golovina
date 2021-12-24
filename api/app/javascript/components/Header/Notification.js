import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import PubSub from 'pubsub-js'

import Price from '../Variants/Price'
import { path } from '../Routes'
import { useI18n } from '../I18n'

import styles from './Notification.module.css'
import buttons from '../Buttons.module.css'

Notification.propTypes = {
  locale: PropTypes.string.isRequired
}

export default function Notification ({ locale }) {
  const I18n = useI18n(locale)

  const [active, setActive] = useState(false)
  const [variant, setVariant] = useState()

  useEffect(() => {
    window.addEventListener('keydown', onEscapeDown)

    PubSub.subscribe('notification-cart', Subscriber)

    return () => {
      window.removeEventListener('keydown', onEscapeDown)
    }
  }, [])

  const onEscapeDown = event => {
    if (event.key === 'Escape') {
      setActive(false)
    }
  }

  const Subscriber = (msg, data) => {
    setActive(true)
    setVariant(data)
    // console.log(msg, data)
  }

  return (
    <div className={classNames(styles.root, { [styles.active]: active })}>
      <div className={styles.overlay} onClick={() => setActive(false)} />

      {variant &&
        <div>
          <div className={styles.message}>
            {I18n.t('header.notification.added')}
          </div>

          <div className={styles.variant}>
            <div className={styles.image}>
              {variant.images.length > 0 &&
                <img src={variant.images[0].thumb} />
              }
            </div>

            <div className={styles.data}>
              <h2>
                {variant.title}
              </h2>

              <div className={styles.price}>
                <Price sell={parseFloat(variant.price_sell)} origin={parseFloat(variant.price)} originClass={styles.origin} sellClass={styles.sell} />
              </div>
            </div>
          </div>

          <div className={styles.buttons}>
            <button className={buttons.main} onClick={() => setActive(false)}>
              {I18n.t('header.notification.continue')}
            </button>

            <a href={path('cart_path')} className={classNames(buttons.main, buttons.black)}>
              {I18n.t('header.notification.cart')}
            </a>
          </div>
        </div>
      }
    </div>
  )
}
