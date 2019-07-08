import React, { Component } from 'react'
import PropTypes from 'prop-types'
// import classNames from 'classnames'

import { path } from '../Routes'
import Price from './Price'
import I18n from '../I18n'

import styles from './Grid.module.css'

class Grid extends Component {
  render () {
    const { variants } = this.props

    return (
      <div className={styles.root}>
        {variants.filter(variant => !variant.hide).map((variant, _) =>
          <a href={path('catalog_variant_path', { slug: variant.category.slug, id: variant.id })} key={variant.id} className={styles.item}>
            <div className={styles.image}>
              {variant.images.length > 0 &&
                <img src={variant.images[0].thumb} />
              }
            </div>

            <div className={styles.dt}>
              <div className={styles.desc}>
                <div className={styles.title}>
                  {variant.title}
                </div>

                <div className={styles.price}>
                  <Price sell={variant.price_sell} origin={variant.price} />
                </div>

                {variant.colour > 0 &&
                  <div className={styles.colors}>
                    +{I18n.t('variants.colors', { count: variant.colour })}
                  </div>
                }
              </div>
            </div>
          </a>
        )}
      </div>
    )
  }
}

Grid.propTypes = {
  variants: PropTypes.array
}

export default Grid
