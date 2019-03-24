import React, { Component } from 'react'
import classNames from 'classnames'

import styles from './List.module.css'

class List extends Component {
  render () {
    const { variants } = this.props

    return (
      <div className={styles.root}>
        {variants.filter(variant => variant.image).map((variant, _) =>
          <a href="#" key={variant.id} className={classNames(styles.item, styles[`i${_ % 6}`])}>
            <div className={styles.image}>
              <img src={variant.image} />
            </div>

            <div className={styles.desc}>
              <div className={styles.title}>
                {variant.title}
              </div>

              <div className={styles.price}>
                {variant.price} ₽
              </div>
            </div>
          </a>
        )}
      </div>
    )
  }
}

export default List
