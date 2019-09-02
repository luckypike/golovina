import React, { Component } from 'react'
import PropTypes from 'prop-types'
import debounce from 'lodash.debounce'
import qs from 'querystring'
import axios from 'axios'
// import classNames from 'classnames'

// import Grid from '../Variants/Grid'
import List from '../Variants/List'

import { path } from '../Routes'
import I18n from '../I18n'

import styles from './Index.module.css'
import page from '../Page'
import form from '../Form.module.css'

class Index extends Component {
  state = {
    q: '',
    variants: []
  }

  _loadAsyncDataDebounced = debounce(() => this._loadAsyncData(), 300)

  componentDidMount () {
    this._loadAsyncDataDebounced()
  }

  static getDerivedStateFromProps (props, state) {
    I18n.locale = props.locale
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
      this._loadAsyncDataDebounced()
    }
  }

  _loadAsyncData = async () => {
    if (this.state.q !== '') {
      const res = await axios.get(path('search_path', { format: 'json' }) + `?q=${this.state.q}`)
      this.setState({ ...res.data })
    } else {
      this.setState({ variants: [] })
    }
  }

  render () {
    const { q, variants } = this.state

    return (
      <div className={page.root}>
        <div className={styles.root}>
          <form>
            <label className={form.el}>
              <div className={form.input}>
                <input
                  autoFocus
                  type="text"
                  value={q}
                  name="q"
                  onChange={this.handleInputChange}
                  placeholder={I18n.t('search.form.placeholder')} />
              </div>
            </label>
          </form>

          {variants &&
            <List variants={variants} />
          }
        </div>
      </div>
    )
  }
}

Index.propTypes = {
  history: PropTypes.object,
  location: PropTypes.object,
  locale: PropTypes.string
}

export default Index
