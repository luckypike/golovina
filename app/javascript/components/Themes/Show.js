import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

import { path } from '../Routes'
import I18n from '../I18n'

import List from '../Variants/List'

import page from '../Page'

Show.propTypes = {
  theme: PropTypes.object
}

export default function Show ({ theme }) {
  const [variants, setVariants] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const { data } = await axios.get(path('catalog_theme_path', { format: 'json', id: theme.slug }))

      setVariants(data.variants)
    }

    _fetch()
  }, [])

  return (
    <div className={page.root}>
      <div className={page.title}>
        <h1>{theme.title}</h1>
      </div>

      <div>
        {variants &&
          <List variants={variants} />
        }
      </div>
    </div>
  )
}
