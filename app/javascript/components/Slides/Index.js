import React from 'react'
import PropTypes from 'prop-types'

import { useI18n } from '../I18n'

import styles from './Index.module.css'
import page from '../Page.module.css'

Index.propTypes = {
  locale: PropTypes.string
}

export default function Index ({ locale }) {
  const I18n = useI18n(locale)

  return (
    <div className={page.gray}>
      <div className={page.title}>
        <h1>
          {I18n.t('slides.title')}
        </h1>
      </div>

      <div className={styles.root}>
        SLIDES
      </div>
    </div>
  )
}
