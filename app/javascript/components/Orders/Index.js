import React, { Component } from 'react'
import axios from 'axios'

import { path } from '../Routes'
import List from '../Orders/List'

import page from '../Page'

import styles from './Index.module.css'

class Index extends Component {
  state = {
    orders: null
  }

  componentDidMount = async () => {
    const res = await axios.get(path('orders_path', { format: 'json' }))
    this.setState({ ...res.data })
  }

  render () {
    const { orders } = this.state

    return (
      <div className={page.gray}>
        <div className={page.title}>
          <h1>Заказы</h1>
        </div>

        <div>
          {orders &&
            <List orders={orders} />
          }
        </div>
      </div>
    )
  }
}

export default Index
