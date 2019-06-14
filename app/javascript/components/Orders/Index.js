import React, { Component } from 'react'
import axios from 'axios'
import update from 'immutability-helper'

import { path } from '../Routes'
import List from '../Orders/List'

import page from '../Page'

import styles from './Index.module.css'

class Index extends Component {
  state = {
    orders: null,
    states: null,
    status: 'paid',
    link: true
  }

  componentDidMount = async () => {
    const res = await axios.get(path('orders_path', { format: 'json' }))
    this.setState({ ...res.data })
  }

  render () {
    const { orders, states, status, link } = this.state

    return (
      <div className={page.gray}>
        <div className={page.title}>
          <h1>Заказы</h1>
        </div>

        <div>
          {orders &&
            <List link={link} orders={orders.filter( o => o.state == status )} states={states} status={status} onStateChange={this.handleStateChange} onOrderChange={this.handleOrderChange}/>
          }
        </div>
      </div>
    )
  }

  handleOrderChange = (id) => {
    let key = this.state.orders.findIndex(o => o.id == id)

    const orders = update(this.state.orders, {
      [key]: {
        state: {
          $set: 'archived'
        }
      }
    });

    this.setState(state => ({
      orders: orders
    }))
  }

  handleStateChange = (status) => {
    this.setState(state => ({
      status: status
    }))
  }
}

export default Index
