import React, { useEffect, useState } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

import { path } from '../Routes'
import { I18nContext, useI18n } from '../I18n'

import List from './List'

import page from '../Page'

Show.propTypes = {
  category: PropTypes.object,
  locale: PropTypes.string.isRequired
}

export default function Show (props) {
  const I18n = useI18n(props.locale)
  const category = props.category
  const [object, setObject] = useState(null)

  useEffect(() => {
    const _loadAsyncData = async () => {
      const { data: { object } } = await axios.get(path('catalog_category_path', { slug: category.slug, format: 'json' }))

      setObject(object)
    }

    _loadAsyncData()
  }, [])

  return (
    <I18nContext.Provider value={I18n}>
      <div className={page.root}>
        <div className={page.title}>
          <h1>
            {category.title}
          </h1>
        </div>

        {object &&
          <List
            object={object}
          />
        }
      </div>
    </I18nContext.Provider>
  )
}
