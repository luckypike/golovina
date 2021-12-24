import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

import { path } from '../Routes'
import { useI18n } from '../I18n'

import Nav from './Nav'
import Refund from './Refund/Refund'

import page from '../Page.module.css'
import styles from './Index.module.css'

Refunds.propTypes = {
  locale: PropTypes.string.isRequired
}

export default function Refunds ({ locale }) {
  const I18n = useI18n(locale)

  const [refunds, setRefunds] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const { data } = await axios.get(path('dashboard_refunds_path', { format: 'json' }))

      setRefunds(data.refunds)
    }

    _fetch()
  }, [])

  return (
    <div className={page.gray}>
      <div className={styles.root}>
        <Nav locale={locale} />

        <div className={page.title}>
          <h1>{I18n.t('dashboard.refunds.title')}</h1>
        </div>

        {refunds && refunds.map(refund =>
          <Refund
            key={refund.id}
            refund={refund}
            locale={locale}
          />
        )}
      </div>
    </div>
  )
}
