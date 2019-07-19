import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

import Price from '../../Variants/Price'

import styles from './Variants.module.css'

Variants.propTypes = {
  variants: PropTypes.array
}

export default function Variants (props) {
  const { variants } = props

  return (
    <div className={styles.variants}>
      {variants.map(variant =>
        <div key={variant.id} className={classNames(styles.variant, styles[variant.state])}>
          <div className={styles.image}>
            {variant.images.length > 0 &&
              <img src={variant.images[0].thumb} />
            }
          </div>

          <div>
            <div className={styles.title}>
              {variant.title}
            </div>

            <div className={styles.price}>
              <Price sell={variant.price_sell} origin={variant.price} />
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
