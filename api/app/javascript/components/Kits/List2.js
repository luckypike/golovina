import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

import Images from '../Variants/Images/Images'

import { path } from '../Routes'
import Price from '../Variants/Price'

import styles from '../Variants/List.module.css'

List2.propTypes = {
  kits: PropTypes.array
}

export default function List2 ({ kits }) {
  return (
    <div className={styles.kits}>
      {kits.filter(kit => kit.variants.filter(variant => variant.state !== 'archived').length > 0).map(kit =>
        <a href={path('kit_path', { id: kit.id })} key={kit.id} className={classNames(styles.item, { [styles.single]: kit.images.length < 2 && !kit.video })}>
          <Kit
            key={kit.id}
            kit={kit}
          />
        </a>
      )}
    </div>
  )
}

Kit.propTypes = {
  kit: PropTypes.object
}

function Kit ({ kit }) {
  return (
    <>
      <Images
        variant={kit}
      />

      <div className={styles.dt}>
        <div className={styles.desc}>
          <div className={styles.title}>
            {kit.title}
          </div>

          {kit.price > 0 &&
            <div className={styles.price}>
              <Price sell={parseFloat(kit.price)} />
            </div>
          }
        </div>
      </div>
    </>
  )
}
