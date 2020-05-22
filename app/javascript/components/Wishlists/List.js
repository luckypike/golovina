import React from 'react'
import PropTypes from 'prop-types'

import Variant from './Variant'

import styles from './List.module.css'

List.propTypes = {
  variants: PropTypes.array,
  locale: PropTypes.string.isRequired
}

export default function List ({ variants, locale }) {
  return (
    <div className={styles.root}>
      {variants.map((variant, _) =>
        <Variant key={_} variant={variant} locale={locale}/>
      )}
    </div>
  )
}
