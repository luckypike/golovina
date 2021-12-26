import React from 'react'
import PropTypes from 'prop-types'
// import classNames from 'classnames'

import Wishlist from '../Wishlist'
import Buy from './Buy'
import Price from '../Price'
import { path } from '../../Routes'

// import { I18nContext } from '../../I18n'

import styles from './Short.module.css'

Short.propTypes = {
  variant: PropTypes.object.isRequired
}

export default function Short ({ variant }) {
  return (
    <div className={styles.root}>
      <a href={path('catalog_variant_path', { slug: variant.category.slug, id: variant.id })} className={styles.link}>
        <div className={styles.image}>
          {variant.images.length > 0 &&
            <img src={variant.images[0].thumb} />
          }
        </div>
      </a>

      <div className={styles.dt}>
        <div className={styles.top}>
          <div className={styles.title}>
            {variant.title}
          </div>

          {variant.price_sell > 0 &&
            <div className={styles.price}>
              <Price sell={parseFloat(variant.price_sell)} origin={parseFloat(variant.price)} />
            </div>
          }
        </div>

        <div className={styles.buy}>
          <Buy
            variant={variant}
          />
        </div>

        <div className={styles.wishlist}>
          <Wishlist
            variant={variant}
          />
        </div>
      </div>
    </div>
  )
}
