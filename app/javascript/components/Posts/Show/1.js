import React, { useEffect, useState } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import ReactMarkdown from 'react-markdown'
import Glide from '@glidejs/glide'

import page from '../../Page'
import styles from './1.module.css'

Interview.propTypes = {
  title: PropTypes.string,
  text: PropTypes.string,
  images: PropTypes.array
}

export default function Interview (props) {
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
      <div className={classNames(page.title, styles.title)}>
        <h1>
          {title}
        </h1>
      </div>

      <div className={styles.root}>
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

        <div className={styles.text}>
          <ReactMarkdown source={text} />
        </div>
      </div>
    </div>
  )
}
