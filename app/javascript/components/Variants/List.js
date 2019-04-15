import React, { Component } from 'react'
import classNames from 'classnames'

import { path } from '../Routes'
import Price from './Price'

import styles from './List.module.css'

class List extends Component {
  render () {
    const { variants } = this.props

    return (
      <div className={styles.root}>
        {variants.filter(variant => variant.image).map((variant, _) =>
          <a href={path('catalog_variant_path', { slug: variant.category.slug, id: variant.id })} key={variant.id} className={classNames(styles.item, styles[`i${_ % 6}`])}>
            <div className={styles.image}>
              <img src={variant.image} />
            </div>

            <div className={styles.desc}>
              <div className={styles.title}>

                {variant.latest &&
                  <div className={classNames(styles.label, styles.latest)}>
                    New
                  </div>
                }

                {variant.sale &&
                  <div className={classNames(styles.label, styles.sale)}>
                    Sale
                  </div>
                }

                {variant.title}
              </div>

              <div className={styles.price}>
                <Price sell={variant.price_sell} origin={variant.price} />
              </div>
            </div>
          </a>
        )}
      </div>
    )
  }
}

export default List
