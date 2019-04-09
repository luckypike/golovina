import React, { Component } from 'react'
import axios from 'axios'

import { path } from '../Routes'

import Images from '../Images/Images'

import buttons from '../Buttons.module.css'
import form from '../Form.module.css'
import page from '../Page'

class Form extends React.Component {
  state = {
    images: this.props.values.images || [],
    values: {
      title: this.props.values.title || '',
      slug: this.props.values.slug || '',
      text: this.props.values.text || '',
      desc: this.props.values.desc || '',
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
      path('collection_path', { id: this.props.id }),
      { collection: { ...this.state.values }, authenticity_token: document.querySelector('[name="csrf-token"]').content }
    )

    if(res.headers.location) window.location = res.headers.location
  }

  _handleCreate = async () => {
    const res = await axios.post(
      path('collections_path'),
      { collection: this.state.values, authenticity_token: document.querySelector('[name="csrf-token"]').content }
    )

    if(res.headers.location) window.location = res.headers.location
  }

  render () {
    const { title, id } = this.props
    const { values, images } = this.state

    return (
      <div className={page.gray}>
        <div className={page.title}>
          <h1>{this.props.title ? `Редактирование: ${title}` : 'Новая коллекция'}</h1>
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
                Название на англ. (для ссылки)
              </div>

              <div className={form.input_input}>
                <input type="text" value={values.slug} name="slug" onChange={this.handleInputChange} />
              </div>
            </div>

            <div className={form.input}>
              <div className={form.label}>
                Название тест
              </div>

              <div className={form.input_input}>
                <input type="text" value={values.desc} name="desc" onChange={this.handleInputChange} />
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
              <Images images={images} onImagesChange={this.handleImagesChange}/>
            </div>

            <div>
              <input className={buttons.main} type="submit" value="Сохранить" />
            </div>
          </form>
        </div>
      </div>
    )
  }

  handleImagesChange = (images) => {
    this.setState(state => ({
      values: { ...state.values,
        image_ids: images.map(i => i.id)
      }
    }))
  }
}

export default Form
