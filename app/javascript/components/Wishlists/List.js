import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'

import Variant from './Variant'

import styles from './List.module.css'

List.propTypes = {
  variants: PropTypes.array,
  locale: PropTypes.string.isRequired,
  onRemove: PropTypes.func
}

export default function List ({ variants, locale, onRemove }) {
  return (
    <div className={styles.root}>
      {variants.map((variant, _) =>
        <Variant key={_} variant={variant} locale={locale} onRemove={onRemove}/>
      )}
    </div>
  )
}
