import React, { useEffect, useRef, useState } from 'react'
import PropTypes from 'prop-types'
import Siema from 'siema'
import classNames from 'classnames'

import styles from './Images.module.css'

Images.propTypes = {
  variant: PropTypes.object
}

export default function Images ({ variant }) {
  const [current, setCurrent] = useState(1)
  const mySiema = useRef()
  const init = useRef()

  useEffect(() => {
    const _onResize = () => {
      if (window.getComputedStyle(init.current).getPropertyValue('display') === 'block') {
        if (!mySiema.current && variant.images.length > 1) {
          mySiema.current = new Siema({
            selector: init.current,
            onChange: () => setCurrent(mySiema.current.currentSlide + 1)
          })
        }
      } else if (mySiema.current) {
        mySiema.current.destroy(true)
        mySiema.current = null
      }
    }

    if (window) {
      window.addEventListener('resize', _onResize)
      _onResize()
    }
  }, [])

  return (
    <div className={classNames(styles.images, { [styles.single]: variant.images.length === 1, [styles.twice]: variant.images.length > 1 })}>
      {variant.images.length > 1 &&
        <div className={styles.counter}>{current}/{variant.images.length}</div>
      }

      <div className={styles.root} ref={init}>
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
    </div>
  )
}
