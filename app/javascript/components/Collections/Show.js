import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'
import classNames from 'classnames'
import ReactMarkdown from 'react-markdown'
import 'lazysizes'

import { path } from '../Routes'

import styles from './Show.module.css'

Show.propTypes = {
  id: PropTypes.number
}

export default function Show (props) {
  const { id } = props

  const [collection, setCollection] = useState()

  useEffect(() => {
    const _loadAsyncData = async () => {
      const { data: { collection } } = await axios.get(path('collection_path', { id, format: 'json' }))
      setCollection(collection)
    }

    _loadAsyncData()
  }, [id])

  let singles = []

  if (id === 10) singles = [2, 8, 23]
  if (id === 8) singles = [3, 4, 7, 10, 16, 20, 29, 32, 33, 39]
  if (id === 7) singles = [0, 4, 7, 8, 10, 14, 17, 20, 23, 27, 28, 34, 35, 36, 39, 40, 43, 44, 47]

  if (!collection) return null

  return (
    <div className={styles.root}>
      <div className={styles.title}>
        <h1>
          {collection.title}
        </h1>
      </div>

      {collection.text &&
        <div className={styles.text}>
          <ReactMarkdown source={collection.text} />
        </div>
      }

      <div className={styles.images}>
        {collection.images &&
          collection.images.map((image, index) =>
            <div
              key={index}
              className={
                classNames(
                  [styles.image],
                  {
                    [styles.landscape]: image.width > image.height,
                    [styles.single]: singles.includes(index)
                  }
                )
              }
            >
              <img className="lazyload" data-src={image.collection} />
            </div>
          )
        }
      </div>
    </div>
  )
}
