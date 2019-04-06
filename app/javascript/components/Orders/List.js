import React, { Component } from 'react'
import classNames from 'classnames'

import { path } from '../Routes'
import I18n from '../I18n'
import { currency } from '../Variants/Price'

import styles from './List.module.css'


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
          <div className={styles.details}>
            Получатель:
            <br />
            Телефон:
            <br />
            Адрес: {order.address}
          </div>
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
