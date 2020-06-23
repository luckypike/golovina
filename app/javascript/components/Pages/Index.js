import React, { useEffect, useState } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'
import classNames from 'classnames'

import { path } from '../Routes'
import { useI18n } from '../I18n'

import styles from './Index.module.css'

Index.propTypes = {
  slides: PropTypes.array,
  instagram: PropTypes.string,
  locale: PropTypes.string
}

export default function Index ({ slides, instagram, locale }) {
  const I18n = useI18n(locale)

  const [posts, setPosts] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const { data } = await axios.get(path('instagram_path', { format: 'json' }))

      setPosts(data.posts)
    }

    _fetch()
  }, [])

  return (
    <div className={styles.root}>
      <div className={classNames(styles.slides, { [styles.single]: slides.length === 1 })} id="slides">
        {slides.slice(0, 2).map((slide, _) =>
          <a href={slide.link_relative} key={_} className={styles.slide} style={{ backgroundImage: `url(${slide.image})` }}>
            <div className={styles.text}>
              <div className={styles.title}>{slide.name}</div>
            </div>
          </a>
        )}
      </div>

      <div className={styles.content}>
        {slides.length > 2 &&
          <div className={styles.subslides}>
            {slides.slice(2, slides.length).map((slide, _) =>
              <a key={_} href={slide.link_relative} className={styles.subslide} style={{ backgroundImage: `url(${slide.image})` }}>
                <div className={styles.text}>
                  <div className={styles.title}>{slide.name}</div>
                </div>
              </a>
            )}
          </div>
        }

        <a target="_blank" href={instagram} rel="noopener noreferrer" className={styles.instagram}>
          golovina.brand
        </a>

        {posts &&
          <div className={styles.posts}>
            {posts.map(post =>
              <a key={post.id} className={styles.post} target="_blank" href={post.permalink} rel="noopener noreferrer">

                {post.media_type === 'VIDEO' &&
                  <video autoPlay loop muted>
                    <source src={post.media_url} />
                  </video>
                }

                {(post.media_type === 'CAROUSEL_ALBUM' || post.media_type === 'IMAGE') &&
                  <img src={post.media_url} />
                }
              </a>
            )}
          </div>
        }
      </div>

      <div className={styles.footer}>
        <div className={styles.mail}>
          <div>
            {I18n.t('static.index.email')}
          </div>
          <a href="mailto:shop@golovina.store">shop@golovina.store</a>
        </div>
        <div className={styles.insta}>
          {/* <div>
            {I18n.t('static.index.instagram')}
          </div>
          <a target="_blank" href={instagram} rel="noopener noreferrer">Golovina.brand</a> */}
        </div>
        <div className={styles.copy}>
          <div>© 2017 – {new Date().getFullYear()} {I18n.t('static.index.copy')}</div>
          <div>{I18n.t('static.index.made_by')} <a href="https://luckypike.com/" target="_blank" rel="noopener noreferrer">L..IKE</a></div>
        </div>
      </div>
    </div>
  )
}
