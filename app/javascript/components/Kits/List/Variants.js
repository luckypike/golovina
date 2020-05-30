import React from 'react'
import PropTypes from 'prop-types'

// import Variant from '../../Variants/Variant/Short'

import { path } from '../../Routes'

import Wishlist from '../../Variants/Wishlist'
import Buy from '../../Variants/Variant/Buy'
import Price from '../../Variants/Price'

import styles from './Variants.module.css'

Variants.propTypes = {
  variants: PropTypes.array
}

export default function Variants ({ variants }) {
  return (
    <div className={styles.variants}>
      {variants.map(variant =>
        <Variant
          key={variant.id}
          className={styles.variant}
          variant={variant}
        />
      )}
    </div>
  )
}

Variant.propTypes = {
  variant: PropTypes.object
}

function Variant ({ variant }) {
  return (
    <div className={styles.variant}>
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
