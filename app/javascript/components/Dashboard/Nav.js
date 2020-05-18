import React from 'react'
import PropTypes from 'prop-types'

import { path } from '../Routes'
import { useI18n } from '../I18n'

import styles from './Nav.module.css'

Nav.propTypes = {
  locale: PropTypes.string.isRequired
}

export default function Nav ({ locale }) {
  const I18n = useI18n(locale)

  return (
    <div className={styles.tabs}>
      <a href={path('dashboard_path')} className={styles.tab}>
        {I18n.t('dashboard.nav.index')}
      </a>

      <a href={path('dashboard_archived_path')} className={styles.tab}>
        {I18n.t('dashboard.nav.archived')}
      </a>

      <a href={path('dashboard_cart_path')} className={styles.tab}>
        {I18n.t('dashboard.nav.cart')}
      </a>
    </div>
  )
}
