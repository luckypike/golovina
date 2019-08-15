import React, { Component } from 'react'
import axios from 'axios'
import update from 'immutability-helper'

import { path } from '../Routes'
import List from './List'

import page from '../Page'

import styles from './Index.module.css'

class Index extends Component {
  state = {
    refunds: null,
  }

  componentDidMount = async () => {
    const res = await axios.get(path('refunds_path', { format: 'json' }))
    this.setState({ ...res.data })
  }

  render () {
    const { refunds } = this.state

    return (
      <div className={page.gray}>
        <div className={page.title}>
          <h1>Возвраты</h1>
        </div>

        <div>
          {refunds &&
            <List link={true} refunds={refunds} onRefundChange={this.handleRefundChange} />
          }
        </div>
      </div>
    )
  }

  handleRefundChange = (id) => {
    console.log('change');
    let key = this.state.refunds.findIndex(r => r.id == id)

    const refunds = update(this.state.refunds, {
      [key]: {
        state: {
          $set: 'done'
        }
      }
    });

    this.setState(state => ({
      refunds: refunds
    }))
  }

}

export default Index
