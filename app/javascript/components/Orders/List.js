import React, { Component } from 'react'
import classNames from 'classnames'

import { path } from '../Routes'
// import Price from './Price'

import styles from './List.module.css'

class List extends Component {
  render () {
    const { orders } = this.props

    return (
      <div className={styles.root}>
        {orders.map(order =>
          <div>
            {order.id}
          </div>
        )}
      </div>
    )
  }
}

export default List
