import React, { useEffect, useState } from 'react'
import axios from 'axios'

import { path } from '../Routes'
import I18n from '../I18n'
import List from './List'

import page from '../Page'

export default function Index (props) {
  const [kits, setKits] = useState()

  useEffect(() => {
    const _loadAsyncData = async () => {
      const { data: { kits } } = await axios.get(path('kits_path', { format: 'json' }))
      setKits(kits)
    }

    _loadAsyncData()
  }, [])

  return (
    <div className={page.root}>
      <div className={page.title}>
        <h1>{I18n.t('kits.title')}</h1>
      </div>

      <div>
        {kits &&
          <List kits={kits} />
        }
      </div>
    </div>
  )
}
