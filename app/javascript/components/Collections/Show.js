import React, { Component } from 'react'
import axios from 'axios'
import classNames from 'classnames'

import { path } from '../Routes'

import List from '../Variants/List'

import page from '../Page'
import styles from './Show.module.css'

class Show extends Component {
  state = {
    collection: null
  }

  componentDidMount = async () => {
    console.log('mount');
    const res = await axios.get(path('collection_path', { id: this.props.id, format: 'json' }))
    this.setState({ ...res.data })
  }

  render () {
    const { collection } = this.state

    if (!collection) return null

    return (
      <div className={styles.root}>
        <div className={styles.title}>
          <h1>
            {collection.title}
          </h1>
        </div>
        <div className={styles.text}>
          {collection.text}
        </div>
        <div className={styles.images}>
          {collection.images &&
            collection.images.map((image, index) =>
              <div key={index} className={classNames([styles.image], {[styles.landscape]: image.width > image.height}, {[styles.single]: [2, 4].includes(index)})}>
                <img src={image.collection} />
              </div>
            )
          }
        </div>
      </div>
    )
  }
}

export default Show
