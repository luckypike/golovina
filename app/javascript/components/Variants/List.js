import React, { Component } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

import { path } from '../Routes'
import Price from './Price'
import I18n from '../I18n'

import styles from './List.module.css'

class List extends Component {
  render () {
    const { variants } = this.props

    return (
      <div className={styles.root}>
        {variants.filter(variant => !variant.hide).map((variant, _) =>
          <a href={path('catalog_variant_path', { slug: variant.category.slug, id: variant.id })} key={variant.id} className={classNames(styles.item, { [styles.single]: variant.images.length === 1 })}>
            <div className={styles.image}>
              {variant.images.length > 0 &&
                <img src={variant.images[0].thumb} />
              }
            </div>

            {variant.images.length !== 1 &&
              <div className={styles.image}>
                {variant.images.length > 1 &&
                  <img src={variant.images[1].thumb} />
                }
              </div>
            }

            <div className={styles.dt}>
              {variant.latest &&
                <div className={styles.label}>
                  New
                </div>
              }

              {variant.sale &&
                <div className={styles.label}>
                  Sale
                </div>
              }

              <div className={styles.desc}>
                <div className={styles.title}>
                  {variant.title}
                </div>

                <div className={styles.price}>
                  <Price sell={variant.price_sell} origin={variant.price} />
                </div>

                {variant.colors > 0 &&
                  <div className={styles.colors}>
                    +{I18n.t('variants.colors', { count: variant.colors })}
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

List.propTypes = {
  variants: PropTypes.array
}

export default List
