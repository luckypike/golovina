import React, { Component } from 'react'
import axios from 'axios'
import classNames from 'classnames'

import { path } from '../Routes'

import styles from './Images.module.css'

class ImageItem extends React.Component {
  state = {
    deleting: false
  }

  render () {
    const { image } = this.props

    return (
      <>
        <img src={image.preview} />
        <div className={styles.control}>
          <div className={classNames([styles.a], [styles.destroy], {[styles.deleting]: this.state.deleting})} onClick={() => this.handeDelete(image.id)}></div>
        </div>
      </>
    )
  }

  handeDelete = async (id) => {
    const res = await axios.delete(
      path('image_path', { id: id }), {params: {authenticity_token: document.querySelector('[name="csrf-token"]').content}}
    ).then(
      this.setState({ deleting: true })
    )

    if (this.props.onImagesChange) {
      this.props.onImagesChange(id)
    }
  }
}

export default ImageItem
