import React, { Component } from 'react'
import classNames from 'classnames'

import { path } from '../Routes'

import styles from './List.module.css'

class List extends Component {
  render () {
    const { kits } = this.props

    return (
      <div className={styles.root}>
        {kits.map((kit, _) =>
          <div className={classNames(styles.item, styles[`i${_ % 2}`])}>
            <div className={styles.primary}>
              <img src={kit.images[0].large} />
            </div>

            <div className={styles.secondary}>
              <img src={kit.images[1].large} />
            </div>
          </div>
        )}
      </div>
    )
  }
}

export default List
