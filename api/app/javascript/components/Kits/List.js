import React, { useContext } from 'react'
import PropTypes from 'prop-types'

import Variants from './List/Variants'
import { I18nContext } from '../I18n'
import Images from './List/Images'

import styles from './List.module.css'

List.propTypes = {
  kits: PropTypes.array
}

export default function List ({ kits }) {
  return (
    <div className={styles.kits}>
      {kits.filter(kit => kit.variants.filter(variant => variant.state !== 'archived').length > 0).map(kit =>
        <Kit
          key={kit.id}
          kit={kit}
        />
      )}
    </div>
  )
}

Kit.propTypes = {
  kit: PropTypes.object
}

function Kit ({ kit }) {
  const I18n = useContext(I18nContext)

  return (
    <div key={kit.id} className={styles.kit}>
      <div className={styles.title}>
        <p className={styles.additional}>
          {I18n.t('kit.variants', { count: kit.variants.length })}
        </p>
      </div>

      <div className={styles.slider}>
        <Images
          images={kit.images}
          video={kit.video}
        />
      </div>

      <div className={styles.variants}>
        <Variants
          variants={kit.variants}
        />
      </div>
    </div>
  )
}
