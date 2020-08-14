import React, { useEffect, useState } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

import { path } from '../Routes'
import { I18nContext, useI18n } from '../I18n'

import List from '../Variants/List'
import List2 from '../Kits/List2'

import page from '../Page'

Show.propTypes = {
  category: PropTypes.object,
  locale: PropTypes.string.isRequired
}

export default function Show (props) {
  const I18n = useI18n(props.locale)
  const category = props.category
  const [kits, setKits] = useState(null)
  const [variants, setVariants] = useState(null)

  useEffect(() => {
    const _loadAsyncData = async () => {
      const { data: { kits, variants } } = await axios.get(path('catalog_category_path', { slug: category.slug, format: 'json' }))
      setKits(kits)
      setVariants(variants)
    }

    _loadAsyncData()
  }, [])

  return (
    <I18nContext.Provider value={I18n}>
      <div className={page.root16}>
        <div className={page.title}>
          <h1>
            {category.title}
          </h1>
        </div>

        <div>
          {kits &&
            <List2 kits={kits} />
          }
          {variants &&
            <List variants={variants} />
          }
        </div>
      </div>
    </I18nContext.Provider>
  )
}
