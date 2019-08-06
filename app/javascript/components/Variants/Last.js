import React, { Component } from 'react'
import axios from 'axios'

import { path } from '../Routes'

import List from './List'

import page from '../Page'

class Latest extends Component {
  state = {
    variants: null
  }

  componentDidMount = async () => {
    const res = await axios.get(path('catalog_last_path', { format: 'json' }))
    this.setState({ ...res.data })
  }

  render () {
    const { variants } = this.state

    return (
      <div className={page.root}>
        <div className={page.title}>
          <h1>Последняя вещь</h1>
          <p>
            Успей купить последнюю вещь с бесплатной доставкой
          </p>
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

export default Latest