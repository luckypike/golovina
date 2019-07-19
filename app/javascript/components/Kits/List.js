import React from 'react'
import PropTypes from 'prop-types'
// import classNames from 'classnames'

import Variants from './List/Variants'
import I18n from '../I18n'

import styles from './List.module.css'

List.propTypes = {
  kits: PropTypes.array
}

export default function List (props) {
  const { kits } = props

  return (
    <div className={styles.kits}>
      {kits.map(kit =>
        <div key={kit.id} className={styles.kit}>
          <div className={styles.images}>
            <div className={styles.image}>
              <img src={kit.images[0].thumb} />
            </div>
          </div>

          <div className={styles.title}>
            <h2>
              {kit.title}
            </h2>

            <p className={styles.additional}>
              {I18n.t('kit.variants', { count: kit.variants.length })}
            </p>
          </div>

          <div className={styles.variants}>
            <Variants variants={kit.variants} />
          </div>
        </div>
      )}
    </div>
  )
}
