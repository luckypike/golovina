import React from 'react'
import PropTypes from 'prop-types'

import Variant from '../../Variants/Variant/Short'

import styles from './Variants.module.css'

Variants.propTypes = {
  variants: PropTypes.array
}

export default function Variants ({ variants }) {
  return (
    <div className={styles.variants}>
      {variants.map(variant =>
        <div key={variant.id} className={styles.variant}>
          <Variant variant={variant} />
        </div>
      )}
    </div>
  )
}
