import React, { useEffect, useState } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import ReactMarkdown from 'react-markdown'
import Glide from '@glidejs/glide'

import page from '../../Page'
import styles from './2.module.css'

Collection.propTypes = {
  title: PropTypes.string,
  text: PropTypes.string,
  images: PropTypes.array
}

export default function Collection (props) {
  const [index, setIndex] = useState(1)
  const mount = React.createRef()
  let glide = null

  useEffect(() => {
    glide = new Glide(mount.current, {
      rewind: false,
      gap: 0
    })

    glide.on('run', move => {
      setIndex(glide.index + 1)
    })

    glide.mount()
  }, [])

  const { title, text, images } = props

  return (
    <div className={page.root}>
      <div className={page.title}>
        <h1>
          {title}
        </h1>
      </div>

      <div className={styles.text}>
        <ReactMarkdown source={text} />
      </div>

      <div className={styles.video}>
        <div className={styles.player}>
          <iframe
            src="https://www.youtube.com/embed/MphgaDHqFL4?modestbranding=1&autohide=1&showinfo=0&rel=0&cc_load_policy=1"
            frameBorder="0"
            allow="autoplay; encrypted-media"
            allowFullScreen
          />
        </div>
      </div>

      <div className={classNames('glide', styles.images)} ref={mount}>
        {images.length > 1 &&
          <div className={styles.counter}>
            {index}/{images.length}
          </div>
        }
        <div className="glide__track" data-glide-el="track">
          <div className={classNames('glide__slides', styles.slides)}>
            {images.map((image, i) =>
              <div className={classNames('glide__slide', styles.image)} key={i}>
                <img src={image.collection} />
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  )
}
