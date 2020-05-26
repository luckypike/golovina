import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

import { useI18n } from '../I18n'
import { path } from '../Routes'

import Size from './Index/Size'
import Preorder from './Index/Preorder'

import styles from './Index.module.css'
import page from '../Page.module.css'

Index.propTypes = {
  variant_id: PropTypes.number.isRequired,
  locale: PropTypes.string.isRequired
}

export default function Index ({ variant_id: variantId, locale }) {
  const I18n = useI18n(locale)

  const [variant, setVariant] = useState()
  const [availabilities, setAvailabilities] = useState()
  const [sizes, setSizes] = useState()
  // const [stores, setStores] = useState()

  const _fetch = async () => {
    const { data } = await axios.get(path('variant_availabilities_path', { variant_id: variantId, format: 'json' }))

    setAvailabilities(data.availabilities)
    setSizes(data.sizes)
    // setStores(data.stores)
    setVariant(data.variant)
  }

  useEffect(() => {
    _fetch()
  }, [])

  return (
    <div className={page.gray}>
      <div className={page.title}>
        <h1>{I18n.t('availabilities.index.title')}</h1>
      </div>

      <div className={styles.root}>
        {sizes && availabilities && variant &&
          <div>
            <div className={styles.preorder}>
              <Preorder
                variant={variant}
                _fetch={_fetch}
              />
            </div>

            {sizes.map(size =>
              <div key={size.id} className={styles.size}>
                <Size
                  variantId={variantId}
                  size={size}
                  availabilities={availabilities}
                  _fetch={_fetch}
                />
              </div>
            )}
          </div>
        }
      </div>
    </div>
  )
}
