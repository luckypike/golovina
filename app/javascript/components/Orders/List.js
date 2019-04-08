import React, { Component } from 'react'
import classNames from 'classnames'

import { path } from '../Routes'
import I18n from '../I18n'
import Price, { currency } from '../Variants/Price'

import styles from './List.module.css'
import buttons from '../Buttons.module.css'

class Item extends Component {
  state = {
    toggle: false
  }

  render () {
    const { order } = this.props
    const { toggle } = this.state

    return (
      <div className={styles.order}>
        <div className={styles.handle} onClick={() => this.setState(state => ({ toggle: !state.toggle }))}>
          <div className={styles.title}>
            <div className={classNames(styles.state, styles[order.state])}>
              {I18n.t(`order.state.${order.state}`)}
            </div>

            <div className={styles.number}>
              № {order.number}
            </div>

            <div className={styles.created_at}>
              {order.created_at}
            </div>
          </div>

          <div className={styles.what}>
            {I18n.t('order.quantity', { count: order.quantity, amount: currency(order.amount) })}
          </div>
        </div>

        {toggle &&
          <>
            <div className={styles.details}>
              Получатель: {order.user.title}
              <br />
              Телефон: {order.user.phone}
              <br />
              Адрес: {order.address}
            </div>

            {order.items.filter(item => !item.available).length == 0 && order.purchasable &&
              <div className={styles.pay}>
                <a href={path('pay_order_path', { id: order.id })} className={buttons.main}>
                  Оплатить
                </a>
              </div>
            }

            <div className={styles.items}>
              {order.items.map(item =>
                <div className={styles.item} key={item.id}>
                  <div className={styles.image}>
                    <img src={item.variant.image} />
                  </div>

                  <div className={styles.title}>
                    {item.variant.title}
                  </div>

                  <div className={styles.color}>
                    <Price sell={item.variant.price_sell} origin={item.variant.price} />
                  </div>

                  <div className={styles.color}>
                    Цвет: {item.color.title}
                  </div>

                  <div className={styles.size}>
                    Размер: {item.size.title}
                  </div>

                  <div className={classNames(styles.quantity, { [styles.unavailable]: !item.available })}>
                    Количество: {item.quantity} {!item.available ? ` (доступно: ${item.quantity_available})` : null}
                  </div>
                </div>
              )}
            </div>
          </>
        }
      </div>
    )
  }
}


class List extends Component {
  render () {
    const { orders } = this.props

    return (
      <div className={styles.root}>
        {orders.map(order =>
          <Item key={order.id} order={order} />
        )}
      </div>
    )
  }
}

export default List
