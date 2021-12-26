import React, { useEffect, useState } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

import { path } from '../Routes'
import { I18nContext, useI18n } from '../I18n'

import List from '../Catalog/List'

import page from '../Page'

Show.propTypes = {
  category: PropTypes.object,
  locale: PropTypes.string.isRequired
}

export default function Show ({ locale, category }) {
  const I18n = useI18n(locale)

  const [items, setItems] = useState()

  useEffect(() => {
    const _loadAsyncData = async () => {
      const { data } = await axios.get(path('catalog_category_path', { slug: category.slug, format: 'json' }))

      setItems(data.items)
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

        {items &&
          <List
            items={items}
          />
        }
      </div>
    </I18nContext.Provider>
  )
}
