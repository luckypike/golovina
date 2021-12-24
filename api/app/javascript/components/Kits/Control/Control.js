import React, { Component } from 'react'
import axios from 'axios'
import classNames from 'classnames'

import { path } from '../../Routes'

import KitItem from './KitItem'

import page from '../../Page'
import buttons from '../../Buttons.module.css'
import styles from './Control.module.css'

class Control extends Component {
  state = {
    kits: null,
    state: 'active',
  }

  componentDidMount = async () => {
    this._loadAsyncData()
  }

  render () {
    const { kits, state } = this.state

    return (
      <div className={page.gray}>
        <div className={page.title}>
          <h1>Все образы</h1>
        </div>

        <div className={styles.root}>

          <div className={styles.edit}>
            <a className={buttons.main} href={path('new_kit_path')}>Добавить образ</a>
          </div>

          <div className={styles.states}>
            <div className={classNames(styles.state, { [styles.active]: 'active' == state})} onClick={()=>this.handleStateChange('active')}>
              Активный
            </div>
            <div className={classNames(styles.state, { [styles.active]: 'archived' == state})} onClick={()=>this.handleStateChange('archived')}>
              Архивный
            </div>
          </div>

          {kits &&
            <div className={styles.kits}>
              {kits.filter( k => k.state == state ).map((kit) =>
                <KitItem key={kit.id} kit={kit} onDelete={this.handleKitsChange}/>
              )}
            </div>
          }
        </div>
      </div>
    )
  }

  _loadAsyncData() {
    this._asyncRequest = axios.CancelToken.source();

    axios.get(path('control_kits_path', { format: 'json' })).then(res => {this.setState(state => ({
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

export default Control
