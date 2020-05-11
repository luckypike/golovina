import React from 'react'
import PropTypes from 'prop-types'

import User from './Show/User'

import { useI18n } from '../I18n'

import styles from './Show.module.css'
import page from '../Page.module.css'

Show.propTypes = {
  locale: PropTypes.string.isRequired
}

export default function Show ({ locale }) {
  const I18n = useI18n(locale)

  return (
    <div className={page.gray}>
      <div className={page.title}>
        <h1>{I18n.t('accounts.show.title')}</h1>
      </div>

      <div className={styles.root}>
        <div className={styles.user}>
          <User locale={locale} />
        </div>
      </div>
    </div>
  )
}
