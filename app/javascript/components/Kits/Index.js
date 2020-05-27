import React, { useEffect, useState } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

import { path } from '../Routes'
import { I18nContext, useI18n } from '../I18n'
import List from './List'

import page from '../Page.module.css'

Index.propTypes = {
  locale: PropTypes.string.isRequired
}

export default function Index ({ locale }) {
  const I18n = useI18n(locale)

  const [kits, setKits] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const { data: { kits } } = await axios.get(path('kits_path', { format: 'json' }))
      setKits(kits)
    }

    _fetch()
  }, [])

  return (
    <I18nContext.Provider value={I18n}>
      <div className={page.root16}>
        <div className={page.title}>
          <h1>
            {I18n.t('kits.title')}
          </h1>
        </div>

        {kits &&
          <List
            kits={kits}
          />
        }
      </div>
    </I18nContext.Provider>
  )
}
