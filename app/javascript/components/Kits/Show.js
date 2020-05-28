import React, { useEffect, useState } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

import { path } from '../Routes'
import { I18nContext, useI18n } from '../I18n'
import List from './List'

import page from '../Page'

Show.propTypes = {
  id: PropTypes.number,
  locale: PropTypes.string.isRequired
}

export default function Show (props) {
  const I18n = useI18n(props.locale)
  const [kit, setKit] = useState()

  useEffect(() => {
    const _loadAsyncData = async () => {
      const { data: { kit } } = await axios.get(path('kit_path', { id: props.id, format: 'json' }))
      setKit(kit)
    }

    _loadAsyncData()
  }, [])

  return (
    <I18nContext.Provider value={I18n}>
      <div className={page.root}>
        <div>
          {kit &&
            <List kits={[kit]} />
          }
        </div>
      </div>
    </I18nContext.Provider>
  )
}
