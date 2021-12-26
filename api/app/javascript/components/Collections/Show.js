import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'
import classNames from 'classnames'
import ReactMarkdown from 'react-markdown'
import 'lazysizes'

import { path } from '../Routes'

import styles from './Show.module.css'

Show.propTypes = {
  id: PropTypes.number,
  slug: PropTypes.string
}

export default function Show (props) {
  const { id, slug } = props

  const [collection, setCollection] = useState()

  useEffect(() => {
    const _loadAsyncData = async () => {
      const { data: { collection } } = await axios.get(path('collection_path', { id: slug, format: 'json' }))
      setCollection(collection)
    }

    _loadAsyncData()
  }, [id])

  let singles = []
  let full = []

  if (id === 20) full = Array.from(Array(12).keys())
  if (id === 19) full = Array.from(Array(20).keys())
  if (id === 18) full = Array.from(Array(30).keys())
  if (id === 17) full = Array.from(Array(32).keys())
  if (id === 16) full = Array.from(Array(30).keys())
  if (id === 15) full = Array.from(Array(30).keys())
  if (id === 14) full = Array.from(Array(26).keys())
  if (id === 13) full = Array.from(Array(38).keys())
  if (id === 12) full = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42]
  if (id === 11) full = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]
  if (id === 10) singles = [2, 8, 23]
  if (id === 8) singles = [3, 4, 7, 10, 16, 20, 29, 32, 33, 39]
  if (id === 7) singles = [0, 4, 7, 8, 10, 14, 17, 20, 23, 27, 28, 34, 35, 36, 39, 40, 43, 44, 47]
  if (id === 6) singles = [18, 24]
  if (id === 5) singles = [3, 8, 14, 21, 28, 31]
  if (id === 3) singles = [7]
  if (id === 1) singles = [14, 15, 18, 20, 22]

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
              data-i={index}
              className={
                classNames(
                  [styles.image],
                  {
                    [styles.landscape]: image.width > image.height,
                    [styles.single]: singles.includes(index),
                    [styles.full]: full.includes(index) || id >= 13
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
