import React, { Component } from 'react'
import axios from 'axios'
import classNames from 'classnames'

import page from '../Page'

import styles from './Orders.module.css'

class Orders extends Component {
  state = {
    ordefs: null
  }

  render () {
    const { orders } = this.state

    return (
      <div className={page.gray}>
        <div className={page.title}>
          <h1>Вашы заказы</h1>
        </div>

        ЗАКАЗЫ
      </div>
    )
  }
}

export default Orders
