import React, { Component } from 'react'
import classNames from 'classnames'
import Dropzone from 'react-dropzone'
import { SortableContainer, SortableElement, sortableHandle } from 'react-sortable-hoc'

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
          <List images={images} onImagesChange={this.handleImagesChange} onSortEnd={this._onSortEnd} axis={'x'} useDragHandle />
        }

        {files.map((file, _) =>
          <Image file={file} key={_} onFileUpload={this.handleFileUpload}/>
        )}
      </div>
    )
  }

  _onSortEnd = ({ oldIndex, newIndex }) => {
    let images = this.state.images
    images.splice( oldIndex, 1, images.splice(newIndex,1,images[oldIndex])[0] );
    this.setState({
      images: images
    }, () => {
      this.props.onImagesChange(this.state.images)
    });
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

const DragHandle = sortableHandle(() => <div className={styles.drag} />)

const Item = SortableElement(({ image, onImagesChange }) => {
  return (
    <div className={styles.item}>
      <DragHandle />
      <ImageItem image={image} onImagesChange={onImagesChange}></ImageItem>
    </div>
  )
})

const List = SortableContainer(({ images, onImagesChange }) => {
  return (
    <div className={styles.images}>
      {images.map((image, index) => (
        <Item key={image.id} index={index} image={image} onImagesChange={onImagesChange}/>
      ))}
    </div>
  )
})

export default Images
