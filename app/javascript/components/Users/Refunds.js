import React, { Component } from 'react'
import axios from 'axios'
import classNames from 'classnames'

import { path } from '../Routes'
import List from '../Refunds/List'

import page from '../Page'

import styles from './Orders.module.css'

class Refunds extends Component {
  state = {
    refunds: null
  }

  componentDidMount = async () => {
    const res = await axios.get(path('refunds_user_path', { id: this.props.user.id, format: 'json' }))
    this.setState({ ...res.data })
  }

  render () {
    const { refunds } = this.state

    return (
      <div className={page.gray}>
        <div className={page.title}>
          <h1>Ваши возвраты</h1>
        </div>

        <div>
          {refunds &&
            <List refunds={refunds} />
          }
        </div>
      </div>
    )
  }
}

export default Refunds
