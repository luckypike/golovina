import React, { useEffect, useRef } from 'react'
import PropTypes from 'prop-types'
import Siema from 'siema'
import classNames from 'classnames'

import Variants from './List/Variants'
import I18n from '../I18n'

import styles from './List.module.css'

List.propTypes = {
  kits: PropTypes.array
}

function Kit (props) {
  const { kit } = props
  const slider = useRef(null)
  const mount = useRef(null)

  useEffect(() => {
    const _updateDimensions = () => {
      if(mount.current) {
        mount.current.destroy(true)
      }

      mount.current = new Siema({
        selector: slider.current
      })
    }

    _updateDimensions()

    window.addEventListener('resize', _updateDimensions)
  }, [])

  return (
    <div key={kit.id} className={styles.kit}>
      <div ref={slider} className={classNames('siema', styles.images)}>
        {kit.images.map((image, index) =>
          <div key={index} className={styles.image}>
            <img src={image.thumb} />
          </div>
        )}
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
