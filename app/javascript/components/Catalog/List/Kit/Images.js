import React, { useState, useRef, useEffect, useContext } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import 'keen-slider/keen-slider.min.css'
import { useKeenSlider } from 'keen-slider/react'
import { Waypoint } from 'react-waypoint'

import { VideoContext } from '../../VideoContext'

import styles from './Images.module.css'

Images.propTypes = {
  images: PropTypes.array,
  video: PropTypes.string,
  poster: PropTypes.string,
  videoHide: PropTypes.bool
}

export default function Images ({ images, video, poster, videoHide }) {
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

      {video && !videoHide &&
        <div className={classNames('keen-slider__slide', styles.image)}>
          <Video
            poster={poster && `https://storage.yandexcloud.net/golovina-production/${poster}`}
            src={`https://golovina.store/video/${video}.mp4`}
          />
        </div>
      }

      {images && images.map((image, index) =>
        <React.Fragment key={image.id}>
          <div className={classNames('keen-slider__slide', styles.image)}>
            <img src={image.thumb} />
          </div>

          {index === 0 && video && videoHide &&
            <div className={classNames('keen-slider__slide', styles.image)}>
              <Video
                poster={poster && `https://storage.yandexcloud.net/golovina-production/${poster}`}
                src={`https://golovina.store/video/${video}.mp4`}
              />
            </div>
          }
        </React.Fragment>
      )}
    </div>
  )
}

Video.propTypes = {
  src: PropTypes.string.isRequired,
  poster: PropTypes.string
}

function Video ({ src, poster }) {
  const { played, setPlayed } = useContext(VideoContext)

  const videoRef = useRef()
  const [play, setPlay] = useState(false)

  const handleEnter = () => {
    if (played === 0 && !play) {
      videoRef.current.play()
      setPlayed(1)
      setPlay(true)
    }
  }

  const handleLeave = () => {
    if (played === 1 && play) {
      videoRef.current.pause()
      setPlayed(0)
      setPlay(false)
    }
  }

  const handleClick = e => {
    if (!play) {
      videoRef.current.play()
      e.preventDefault()
    }
  }

  useEffect(() => {
    setPlay(!videoRef.current.paused)
  }, [])

  return (
    <div className={classNames(styles.video, { [styles.paused]: !play })} onClick={handleClick}>
      <Waypoint onEnter={handleEnter} onLeave={handleLeave} topOffset={'54%'} bottomOffset={'45%'}>
        <video
          ref={videoRef}
          loop
          playsInline
          muted
          preload="metadata"
          poster={poster}
          onPlay={() => setPlay(true)}
          onPause={() => setPlay(false)}
        >
          <source src={src} type="video/mp4" />
        </video>
      </Waypoint>
    </div>
  )
}
