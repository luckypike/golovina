import React, { Component } from 'react'
import axios from 'axios'
import classNames from 'classnames'

import { path } from '../Routes'
import List from '../Orders/List'

import page from '../Page'

import styles from './Orders.module.css'

class Orders extends Component {
  state = {
    orders: null
  }

  componentDidMount = async () => {
    const res = await axios.get(path('orders_user_path', { id: this.props.user.id, format: 'json' }))
    this.setState({ ...res.data })
  }

  render () {
    const { orders } = this.state

    return (
      <div className={page.gray}>
        <div className={page.title}>
          <h1>Ваши заказы</h1>
        </div>

        <div>
          <div className={styles.states}>
            <a href={path('orders_user_path', { id: this.props.user.id })} className={classNames(styles.state, { [styles.active]: true })}>
              Заказы
            </a>
            <a href={path('refunds_user_path', { id: this.props.user.id })} className={styles.state}>
              Возвраты
            </a>
          </div>

          {orders &&
            <List orders={orders} />
          }
        </div>
      </div>
    )
  }
}

export default Orders
