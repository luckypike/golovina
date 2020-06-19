import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

import { path } from '../Routes'
import { I18nContext, useI18n } from '../I18n'

import page from '../Page.module.css'
import styles from './Catalog.module.css'

Catalog.propTypes = {
  locale: PropTypes.string.isRequired
}

export default function Catalog ({ locale }) {
  const I18n = useI18n(locale)

  return (
    <I18nContext.Provider value={I18n}>
      <div className={page.gray}>
        <div className={styles.root}>
          <div className={page.title}>
            <h1>{I18n.t('dashboard.catalog.title')}</h1>
          </div>

        </div>
      </div>
    </I18nContext.Provider>
  )
}
