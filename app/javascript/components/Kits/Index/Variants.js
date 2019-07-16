import React from 'react'
import PropTypes from 'prop-types'

import styles from './Variants.module.css'

Variants.propTypes = {
  variants: PropTypes.array
}

export default function Variants (props) {
  const { variants } = props

  return (
    <div className={styles.variants}>
      {variants.map(variant =>
        <div key={variant.id} className={styles.variant}>
          <div className={styles.image}>
            {variant.images.length > 0 &&
              <img src={variant.images[0].thumb} />
            }
          </div>

          <div className={styles.ttl}>
            {variant.title}
          </div>
        </div>
      )}
    </div>
  )
}
