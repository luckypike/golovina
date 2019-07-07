import React, { Component } from 'react'
import PropTypes from 'prop-types'
// import debounce from 'lodash.debounce'
import AwesomeDebouncePromise from 'awesome-debounce-promise'
import qs from 'querystring'
import axios from 'axios'
// import classNames from 'classnames'

import { path } from '../Routes'

import styles from './Index.module.css'
import page from '../Page'

class Index extends Component {
  state = {
    q: ''
  }

  _loadAsyncDataDebounced = AwesomeDebouncePromise(() => axios.get(path('search_path', { format: 'json' })), 300)

  componentDidMount () {
  }

  static getDerivedStateFromProps (props, state) {
    let q = qs.parse(props.location.search.slice(1)).q || ''
    if (state.q !== q) {
      return { q }
    }

    return null
  }

  handleInputChange = ({ target: { name, value } }) => {
    this.props.history.push(path('search_path') + (value !== '' ? `?q=${value}` : ''))
  }

  componentDidUpdate (prevProps, prevState) {
    if (prevState.q !== this.state.q) {
      this._loadAsyncData()
    }
  }

  _loadAsyncData = async () => {
    const res = await this._loadAsyncDataDebounced()
  }

  render () {
    const { q } = this.state

    return (
      <div className={page.root}>
        <div className={styles.root}>
          <input value={q} onChange={this.handleInputChange} />
        </div>
      </div>
    )
  }
}

Index.propTypes = {
  history: PropTypes.object,
  location: PropTypes.object
}

export default Index
