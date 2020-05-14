import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

import styles from './Images.module.css'

Images.propTypes = {
  variant: PropTypes.object
}

export default function Images ({ variant }) {
  return (
    <div className={classNames(styles.images, { [styles.single]: variant.images.length < 2, [styles.twice]: variant.images.length > 1 })}>
      <div className={styles.root}>
        {variant.images.length > 1 && variant.images.map((image, index) =>
          <div key={index} className={styles.image}>
            <img src={image.thumb} />
          </div>
        )}
      </div>

      {variant.images.length === 1 &&
        <div className={styles.image}>
          <img src={variant.images[0].thumb} />
        </div>
      }

      {variant.images.length === 0 &&
        <div className={styles.image} />
      }
    </div>
  )
}
