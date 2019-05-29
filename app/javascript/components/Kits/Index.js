import React, { Component } from 'react'
import axios from 'axios'
import update from 'immutability-helper'

import { path } from '../Routes'

import page from '../Page'

import styles from './Index.module.css'

class Index extends Component {
  state = {
    kits: null,
  }

  componentDidMount = async () => {
    this._loadAsyncData()
  }

  render () {
    const { kits } = this.state

    return (
      <div className={page.root}>
        <div className={page.title}>
          <h1>Все образы</h1>
        </div>

        <div className={styles.root}>

          {kits &&
            <div className={styles.kits}>
              {kits.map((kit) =>
                <div className={styles.kit}>
                  <div className={styles.intro_image}>
                    <img src={kit.images[0]} />
                  </div>
                  <div className={styles.info}>
                    <div className={styles.title}>
                      <div className={styles.state}>New</div>
                      <div className={styles.name}>{kit.title}</div>
                      <div className={styles.variants}>{kit.variants}</div>
                    </div>
                  </div>
                </div>
              )}
            </div>
          }
        </div>
      </div>
    )
  }

  _loadAsyncData() {
    this._asyncRequest = axios.CancelToken.source();

    axios.get(path('kits_path', { format: 'json' })).then(res => {this.setState(state => ({
      kits: res.data.kits
    }))})
  }

  handleKitsChange = (kits) => {
    this.setState(state => ({
      kits: kits
    }))
  }

  handleStateChange = (state) => {
    this.setState({
      state: state
    })
  }
}

export default Index
