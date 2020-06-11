import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

import { path } from '../Routes'
import I18n from '../I18n'

import List from './List'

import page from '../Page'

Section.propTypes = {
  section: PropTypes.string
}

export default function Section ({ section }) {
  const [variants, setVariants] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const { data } = await axios.get(path('catalog_section_path', { format: 'json', section }))

      setVariants(data.variants)
    }

    _fetch()
  }, [])

  return (
    <div className={page.root}>
      <div className={page.title}>
        <h1>{I18n.t(`variants.sections.${section}.title`)}</h1>
      </div>

      <div>
        {variants &&
          <List variants={variants} />
        }
      </div>
    </div>
  )
}
