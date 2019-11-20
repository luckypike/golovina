import React, { useState } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

import Price, { currency } from '../Variants/Price'
import I18n from '../I18n'

import styles from './Items.module.css'

Items.propTypes = {
  cart: PropTypes.object
}

function Items ({ cart }) {
  const [toggle, setToggle] = useState(false)

  return (
    <div className={styles.order}>
      <div className={styles.handle} onClick={() => setToggle(!toggle)}>
        <svg viewBox="0 0 10 20" className={classNames(styles.arr, { [styles.active]: toggle })}>
          <polyline points="1 8 5 12 9 8" />
        </svg>

        <div className={styles.title}>
          <div className={classNames(styles.status, styles.bucket)}>
            Корзина
          </div>

          <div className={styles.number}>
            № {cart.id}
          </div>
        </div>

        <div className={styles.what}>
          {I18n.t('order.quantity', { count: cart.quantity, amount: currency(parseFloat(cart.amount)) })}
        </div>
      </div>

      {toggle &&
        <>
          {cart.user[0].state === 'common' &&
            <div className={styles.details}>
              Имя: {cart.user[0].name}
              <br />
              Фамилия: {cart.user[0].sname}
              <br />
              Телефон: {cart.user[0].phone}
              <br />
              Почта: {cart.user[0].email}
              <br />
            </div>
          }

          {cart.user[0].state === 'guest' &&
            <div className={styles.details}>
              Гость № {cart.user[0].id}
            </div>
          }

          <div className={styles.items}>
            {cart.items.map(item =>
              <div key={item.id} className={styles.item}>
                <div className={styles.image}>
                  {item.variant.images.length > 0 &&
                    <img src={item.variant.images[0].thumb} />
                  }
                </div>

                <div className={styles.title}>
                  {item.variant.title}
                </div>

                <div className={styles.price}>
                  <Price sell={parseFloat(item.variant.price_sell)} origin={parseFloat(item.variant.price)} />
                </div>

                <div className={styles.color}>
                  Цвет: {item.color.title}
                </div>

                <div className={styles.size}>
                  Размер: {item.size.title}
                </div>

                <div className={styles.quantity}>
                  Количество: {item.quantity}
                </div>
              </div>
            )}
          </div>
        </>
      }
    </div>
  )
}

List.propTypes = {
  carts: PropTypes.array
}

export default function List ({ carts }) {
  return (
    <div className={styles.root}>
      {carts.map(cart =>
        <Items key={cart.id} cart={cart} />
      )}
    </div>
  )
}
