import React, { useState, useRef } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import 'keen-slider/keen-slider.min.css'
import { useKeenSlider } from 'keen-slider/react'

import styles from './Images.module.css'

Images.propTypes = {
  images: PropTypes.array,
  video: PropTypes.string
}

export default function Images ({ images, video }) {
  const [sliderRef] = useKeenSlider({
    initial: 0,
    slideChanged (s) {
      setCurrent(s.details().relativeSlide + 1)
    }
  })

  const [current, setCurrent] = useState(1)

  const isSlides = () => {
    const count = images.length

    if (video) {
      return count + 1
    }

    return count
  }

  return (
    <div className={classNames('keen-slider', styles.slider)} ref={sliderRef}>
      <div className={classNames(styles.nav, { [styles.isSlide]: isSlides() > 1 })}>
        {current} / { isSlides() }
      </div>

      {video &&
        <div className={classNames('keen-slider__slide', styles.image)}>
          <Video
            src={`https://golovina.store/video/${video}.mp4`}
          />
        </div>
      }

      {images && images.map((image, index) =>
        <div key={index} className={classNames('keen-slider__slide', styles.image)}>
          <img src={image.thumb} />
        </div>
      )}
    </div>
  )
}

Video.propTypes = {
  src: PropTypes.string.isRequired
}

function Video ({ src }) {
  const videoRef = useRef()

  return (
    <div className={styles.video}>
      <video ref={videoRef} loop playsInline autoPlay preload="metadata">
        <source src={src} type="video/mp4" />
      </video>
    </div>
  )
}
