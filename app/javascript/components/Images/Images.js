import React, { Component } from 'react'
import classNames from 'classnames'
import Dropzone from 'react-dropzone'

import ImageItem from './ImageItem'
import Image from './Image'

import styles from './Images.module.css'

class Images extends React.Component {
  state = {
    files: [],
    images: []
  }


  static getDerivedStateFromProps(props, state) {
    if(props.images !== state.images && state.images.length == 0) {
      return {
        images: props.images,
      };
    }

    return null;
  }

  render () {
    const { images, files} = this.state

    return (
      <div className={styles.images}>

        <Dropzone onDrop={this.onDrop}>
          {({getRootProps, getInputProps}) => (
            <>
              <div className={styles.zone} {...getRootProps()}>
                <input {...getInputProps()} />
                <span className={styles.desc}>Добавить фото</span>
              </div>
            </>
          )}
        </Dropzone>

        {images &&
          images.map(image =>
            <ImageItem key={image.id} image={image} onImagesChange={this.handleImagesChange} />
          )
        }

        {files.map((file, _) =>
          <Image file={file} key={_} onFileUpload={this.handleFileUpload}/>
        )}
      </div>
    )
  }

  handleImagesChange = (id) => {
    let images = this.state.images.filter(i => i.id !== id)
    this.setState(state => ({
      images: images
    }))
  }

  onDrop = (files) => {
    this.setState(state => ({
      files: [...state.files, ...files]
    }));
  }

  handleFileUpload = image => {
    this.setState({
      images: [...this.state.images, image]
    }, () => {
      this.props.onImagesChange(this.state.images)
    });


  }
}

export default Images
