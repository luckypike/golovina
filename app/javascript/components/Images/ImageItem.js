import React, { Component } from 'react'
import axios from 'axios'
import classNames from 'classnames'

import { path } from '../Routes'

import styles from './Images.module.css'

class ImageItem extends React.Component {

  render () {
    const { image } = this.props
    return (
      <div className={styles.item}>
        <img src={image.preview} />
        <div className={styles.control}>
          <div className={classNames([styles.a], [styles.destroy])} onClick={() => this.handeDelete(image.id)}></div>
        </div>
      </div>
    )
  }

  handeDelete = async (id) => {
    const res = await axios.delete(
      path('image_path', { id: id }), {params: {authenticity_token: document.querySelector('[name="csrf-token"]').content}}
    )

    if (this.props.onImagesChange) {
      this.props.onImagesChange(id)
    }
  }
}

export default ImageItem
