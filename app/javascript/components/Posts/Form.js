import React, { Component } from 'react'
import axios from 'axios'

import { path } from '../Routes'

import Images from '../Images/Images'

import buttons from '../Buttons.module.css'
import form from '../Form.module.css'
import page from '../Page'

class Form extends React.Component {
  state = {
    images: [],
    values: {
      title: '',
      text: '',
      images: [],
      image_ids: null,
      images_attributes: [],
    }
  }

  componentDidMount() {
    if (this.props.id) {
      this._loadAsyncData(this.props.id);
    }
  }

  handleInputChange = event => {
    const target = event.target
    const value = target.type === 'checkbox' ? target.checked : target.value
    const name = target.name

    this.setState(state => ({
      values: { ...state.values, [name]: value }
    }))
  }

  handleSubmit = event => {
    if (this.props.id) {
      this._handleUpdate()
    }
    else {
      this._handleCreate()
    }

    event.preventDefault()
  }

  _handleUpdate = async () => {
    const res = await axios.patch(
      path('post_path', { id: this.props.id }),
      { post: { ...this.state.values }, authenticity_token: document.querySelector('[name="csrf-token"]').content }
    )

    if(res.headers.location) window.location = res.headers.location
  }

  _handleCreate = async () => {
    console.log(path('posts_path'));
    const res = await axios.post(
      path('posts_path'),
      { post: this.state.values, authenticity_token: document.querySelector('[name="csrf-token"]').content }
    )

    if(res.headers.location) window.location = res.headers.location
  }

  render () {
    const { title, id } = this.props
    const { values } = this.state

    return (
      <div className={page.gray}>
        <div className={page.title}>
          <h1>{this.props.title ? `Редактирование: ${title}` : 'Новая публикация'}</h1>
        </div>

        <div className={form.root}>
          <form onSubmit={this.handleSubmit}>
            <div className={form.input}>
              <div className={form.label}>
                Название
              </div>

              <div className={form.input_input}>
                <input type="text" value={values.title} name="title" onChange={this.handleInputChange} />
              </div>
            </div>

            <div className={form.input}>
              <div className={form.label}>
                Текст
              </div>

              <div className={form.input_input}>
                <textarea name="text" value={values.text} rows="2" onChange={this.handleInputChange} />
              </div>
            </div>

            <div className={form.input}>
              <div className={form.label}>
                Изображения
              </div>
              <Images images={values.images} onImagesChange={this.handleImagesChange}/>
            </div>

            <div>
              <input className={buttons.main} type="submit" value="Сохранить" />
            </div>
          </form>
        </div>
      </div>
    )
  }

  _loadAsyncData(id) {
    this._asyncRequest = axios.CancelToken.source();

    axios.get(path('edit_post_path', {id: id, format: 'json' }), { authenticity_token: document.querySelector('[name="csrf-token"]').content})
      .then(res => {
        this.setState({
          post: res.data.post,
          values: {
            title: res.data.post.title,
            text: res.data.post.text,
            images: res.data.post.images,
            image_ids: res.data.post.images.map(i => i.id)
          }
        });

        this._asyncRequest = null;
      });
  }

  handleImagesChange = (images) => {
    this.setState(state => ({
      values: { ...state.values,
        image_ids: images.map(i => i.id),
        images_attributes: images.map((i, index) => ({id:i.id, weight: index+1}))
      }
    }))
  }
}

export default Form
