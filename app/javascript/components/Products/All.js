import React, { Component } from 'react'
import axios from 'axios'

import { path } from '../Routes'

import List from './List'

import page from '../Page'

class All extends Component {
  state = {
    variants: null
  }

  componentDidMount = async () => {
    const res = await axios.get(path('all_products_path', { format: 'json' }))
    this.setState({ ...res.data })
  }

  render () {
    const { variants } = this.state

    return (
      <div className={page.root}>
        <div className={page.title}>
          <h1>Все товары</h1>
        </div>

        <div>
          {variants &&
            <List variants={variants} />
          }
        </div>
      </div>
    )
  }
}

export default All
