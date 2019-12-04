import React, { useState } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

import Price from '../../Variants/Price'

import styles from './Item.module.css'

Item.propTypes = {
  subscriber: PropTypes.object
}

export default function Item ({ subscriber }) {
  const [toggle, setToggle] = useState(false)

  return (
    <div className={styles.order}>
      <div className={styles.handle} onClick={() => setToggle(!toggle)}>
        <svg viewBox="0 0 10 20" className={classNames(styles.arr, { [styles.active]: toggle })}>
          <polyline points="1 8 5 12 9 8" />
        </svg>

        <div className={styles.title}>
          <div className={classNames(styles.status, styles.bucket)}>
            Подписка
          </div>

          <div className={styles.number}>
            № {subscriber.id}
          </div>

          <div className={styles.created_at}>
            {subscriber.created_at}
          </div>
        </div>
      </div>

      {toggle &&
        <>
          <div className={styles.details}>
            Почта: {subscriber.user.email}
          </div>

          <div className={styles.items}>
            <div className={styles.item}>
              <div className={styles.image}>
                {subscriber.variant.images.length > 0 &&
                  <img src={subscriber.variant.images[0].thumb} />
                }
              </div>

              <div className={styles.title}>
                {subscriber.variant.title}
              </div>

              <div className={styles.price}>
                <Price sell={parseFloat(subscriber.variant.price_sell)} origin={parseFloat(subscriber.variant.price)} />
              </div>

              <div className={styles.color}>
                Цвет: {subscriber.color.title}
              </div>
            </div>
          </div>
        </>
      }
    </div>
  )
}
