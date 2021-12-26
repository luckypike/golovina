import React, { Component } from 'react'
import classNames from 'classnames'
import Dropzone from 'react-dropzone'
import { SortableContainer, SortableElement, sortableHandle } from 'react-sortable-hoc'
import Check from '!svg-react-loader?!../../images/icons/check.svg'
import update from 'immutability-helper'

import ImageItem from './ImageItem'
import Image from './Image'

import styles from './Images.module.css'

class Images extends Component {
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
    const { images, files } = this.state

    return (
      <List images={images} files={files} onImagesChange={this.handleImagesChange} onFileUpload={this.handleFileUpload} onDrop={this.onDrop} onSortEnd={this._onSortEnd} axis={'xy'} useDragHandle />
    )
  }

  _onSortEnd = ({ oldIndex, newIndex }) => {
    let sort = this.state.images.slice();
    sort.splice(oldIndex, 1);
    sort.splice(newIndex, 0, this.state.images[oldIndex]);

    this.setState({
      images: sort
    }, () => {
      this.props.onImagesChange(sort)
    });
  }

  handleImagesChange = (id) => {
    let images = this.state.images.filter(i => i.id !== id)
    this.setState({
      images: images
    }, () => {
      this.props.onImagesChange(images)
    })
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

const Item = SortableElement(({ images, image, onImagesChange }) => {
  return (
    <div className={styles.item}>
      <div>
        <ImageItem image={image} onImagesChange={onImagesChange}></ImageItem>
      </div>
      <div className={styles.options}>
        <DragHandle />
      </div>
    </div>
  )
})

const List = SortableContainer(({ images, files, onImagesChange, onFileUpload, onDrop }) => {
  return (
    <div className={styles.images}>
      <Dropzone onDrop={onDrop}>
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
        images.map((image, index) => (
          <Item key={image.id} index={index} image={image} onImagesChange={onImagesChange} />
        ))
      }

      {files.map((file, _) =>
        <Image file={file} key={_} onFileUpload={onFileUpload}/>
      )}
    </div>
  )
})

export default Images
