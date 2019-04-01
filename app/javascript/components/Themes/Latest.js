import React, { Component } from 'react'
import axios from 'axios'

import List from '../Kits/List'
import { path } from '../Routes'

import page from '../Page'

class Latest extends Component {
  state = {
    kits: null
  }

  componentDidMount = async () => {
    const res = await axios.get(path('latest_themes_path', { format: 'json' }))
    this.setState({ ...res.data })
  }

  render () {
    const { kits } = this.state

    return (
      <div className={page.root}>
        <div className={page.title}>
          <h1>Новые образы</h1>
        </div>

        {kits &&
          <div>
            <List kits={kits} />
          </div>
        }
      </div>
    )
  }
}

export default Latest
