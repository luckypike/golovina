import React, { useState, useRef } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import 'keen-slider/keen-slider.min.css'
import { useKeenSlider } from 'keen-slider/react'
import { Waypoint } from 'react-waypoint'

import styles from './Images.module.css'

Images.propTypes = {
  images: PropTypes.array,
  video: PropTypes.string
}

export default function Images ({ images, video }) {
  const [sliderRef, slider] = useKeenSlider({
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
            src={`https://golovinamari.com/video/${video}.mp4`}
          />
        </div>
      }

      {images && images.map((image, index) =>
        <div key={index} className={classNames('keen-slider__slide', styles.image)}>
          <img src={image.thumb} />
        </div>
      )}

      <div className={styles.pn} onClick={e => e.preventDefault()}>
        <div
          onClick={e => e.preventDefault() || slider.prev()}
          className={classNames(styles.prev, { [styles.inactive]: slider && current === 1 })}
        >
          <svg viewBox="0 0 28 28" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M18 22L10 14L18 6" stroke="#fafafa" strokeWidth="1.5" />
          </svg>
        </div>

        <div
          onClick={e => e.preventDefault() || slider.next()}
          className={classNames(styles.next, { [styles.inactive]: slider && current === slider.details().size })}
        >
          <svg viewBox="0 0 28 28" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M10 22L18 14L10 6" stroke="#fafafa" strokeWidth="1.5" />
          </svg>
        </div>
      </div>
    </div>
  )
}

Video.propTypes = {
  src: PropTypes.string.isRequired
}

function Video ({ src }) {
  const videoRef = useRef()

  const handleEnter = () => {
    videoRef.current.play()
  }

  const handleLeave = () => {
    videoRef.current.pause()
  }

  return (
    <div className={styles.video}>
      <Waypoint onEnter={handleEnter} onLeave={handleLeave}>
        <video ref={videoRef} loop playsInline muted preload="metadata">
          <source src={src} type="video/mp4" />
        </video>
      </Waypoint>
    </div>
  )
}
