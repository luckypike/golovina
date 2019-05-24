import React, { Component } from 'react'
import classNames from 'classnames'

import { path } from '../Routes'
import Price from './Price'
import I18n from '../I18n'

import styles from './List.module.css'
import Fonts from '../Fonts.module.css'

class List extends Component {
  render () {
    const { variants } = this.props

    console.log(variants);

    return (
      <div className={styles.root}>
        {variants.filter(variant => !variant.hide).map((variant, _) =>
          <a href={path('catalog_variant_path', { slug: variant.category.slug, id: variant.id })} key={variant.id} className={styles.item}>
            {variant.image.map((picture, _) =>
              <>
                <div className={styles.image} key={_} >
                  <img src={picture.thumb} />
                </div>

                {variant.image.length < 2 &&
                  <div className={styles.empty}>
                  </div>
                }
              </>
            )}

            <div className={styles.desc}>

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

              <div className={styles.title}>
                {variant.title}
              </div>

              {variant.colour > 0 &&
                <div className={styles.colors}>
                  +{I18n.t('variants.colors', { count: variant.colour })}
                </div>
              }

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
