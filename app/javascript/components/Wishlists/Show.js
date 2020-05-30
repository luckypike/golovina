import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

import { path } from '../Routes'
import { I18nContext, useI18n } from '../I18n'
import Variant from './Variant'

import page from '../Page.module.css'
import styles from './Show.module.css'

Show.propTypes = {
  locale: PropTypes.string.isRequired
}

export default function Show ({ locale }) {
  const I18n = useI18n(locale)

  const [variants, setVariants] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const { data } = await axios.get(path('wishlist_path', { format: 'json' }))

      setVariants(data.variants)
    }

    _fetch()
  }, [])

  return (
    <I18nContext.Provider value={I18n}>
      <div className={page.root}>
        <div className={page.title}>
          <h1>Избранное</h1>
        </div>

        {variants && variants.length > 0 &&
          <div className={styles.variants}>
            {variants.map(variant =>
              <div key={variant.id} className={styles.variant}>
                <Variant variant={variant} />
              </div>
            )}
          </div>
        }

        {variants && variants.length === 0 &&
          <div>
            У вас нет избранных товаров, добавляйте их в избранное чтобы потом быстрее найти их.
          </div>
        }
      </div>
    </I18nContext.Provider>
  )
}
