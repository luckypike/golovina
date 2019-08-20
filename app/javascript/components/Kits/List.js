import React, { useState, useEffect, useRef } from 'react'
import PropTypes from 'prop-types'
import Siema from 'siema'
import classNames from 'classnames'

import Variants from './List/Variants'
import I18n from '../I18n'

import styles from './List.module.css'

Kit.propTypes = {
  kit: PropTypes.object
}

function Kit ({ kit }) {
  const slider = useRef()
  const mount = useRef()

  const isSlide = () => {
    return kit.images.length > 1
  }

  useEffect(() => {
    if (isSlide()) {
      slider.current = new Siema({
        selector: mount.current,
        onChange: () => {
          setCurrent(slider.current.currentSlide + 1)
        }
      })
    }
  }, [])

  const [current, setCurrent] = useState(1)

  return (
    <div key={kit.id} className={styles.kit}>
      <div className={styles.slider}>
        <div className={classNames(styles.nav, { [styles.isSlide]: isSlide() })}>
          {current} / {kit.images.length}

          {isSlide() &&
            <>
              <div className={styles.prev} onClick={() => slider.current.prev()} />
              <div className={styles.next} onClick={() => slider.current.next()} />
            </>
          }
        </div>

        <div ref={mount} className={styles.images}>
          {kit.images.map((image, index) =>
            <div key={index} className={styles.image}>
              <img src={image.thumb} />
            </div>
          )}
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
  )
}

List.propTypes = {
  kits: PropTypes.array
}

export default function List (props) {
  const { kits } = props

  return (
    <div className={styles.kits}>
      {kits.filter(kit => kit.variants.filter(variant => variant.state !== 'archived').length > 0).map(kit =>
        <Kit key={kit.id} kit={kit}/>
      )}
    </div>
  )
}
