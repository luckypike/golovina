import React, { Component } from 'react'
import axios from 'axios'

import { path } from '../Routes'

import Images from '../Images/Images'

import styles from './Form.module.css'
import page from '../Page'

class Form extends React.Component {
  state = {
    values: this.props.values
  }

  handleInputChange = event => {
    const target = event.target
    const value = target.type === 'checkbox' ? target.checked : target.value
    const name = target.name

    this.setState(state => ({
      values: { ...state.values, [name]: value }
    }))
  }

  handleImagesChange = (images) => {
    this.setState(state => ({
      values: { ...state.values,
        image_ids: images.map(i => i.id),
        images_attributes: images.map((i, index) => ({id:i.id, weight: index+1}))
      }
    }))
  }

  handleSubmit = event => {
    this._handleUpdate()
    event.preventDefault()
  }

  _handleUpdate = async () => {
    console.log(this.props)
    console.log(path('category_path', { id: this.props.id }))
    const res = await axios.patch(
      path('category_path', { id: this.props.id }),
      { category: { ...this.state.values }, authenticity_token: document.querySelector('[name="csrf-token"]').content }
    )

    if(res.headers.location) window.location = res.headers.location
  }

  render () {
    const { title, id } = this.props
    const { values } = this.state

    return (
      <div className={page.gray}>
        <div className={page.title}>
          <h1>Редактирование: {title}</h1>
        </div>

        <div className={styles.root}>
          <form onSubmit={this.handleSubmit}>
            <div>
              <div>
                Название
              </div>

              <div>
                <input value={values.title} name="title" onChange={this.handleInputChange} />
              </div>
            </div>

            <div>
              <div>
                Название на англ. (для ссылки)
              </div>

              <div>
                <input value={values.slug} name="slug" onChange={this.handleInputChange} />
              </div>
            </div>

            <div>
              <div>
                Поведение
              </div>

              <div>
                <select name="state" value={values.state} onChange={this.handleInputChange}>
                  <option value="active">Скрывается при отсутствии товаров</option>
                  <option value="inactive">Скрыта всегда</option>
                </select>
              </div>
            </div>

            <div>
              <div>
                Изображения
              </div>
              <Images images={values.images} onImagesChange={this.handleImagesChange}/>
            </div>

            <div>
              <div>
                <input type="checkbox" name="front" checked={values.front} onChange={this.handleInputChange} />
                Показывать на главной
              </div>
            </div>

            <div>
              <input type="submit" value="Сохранить" />
            </div>
          </form>
        </div>
      </div>
    )
  }
}

export default Form
