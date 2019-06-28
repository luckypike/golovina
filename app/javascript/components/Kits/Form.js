import React, { Component } from 'react'
import axios from 'axios'
import classNames from 'classnames'
import update from 'immutability-helper'

import { path } from '../Routes'

import Images from '../Images/Images'

import buttons from '../Buttons.module.css'
import page from '../Page.module.css'
import form from '../Form.module.css'
import control from './Control/Control.module.css'

class Form extends React.Component {
  state = {
    kit: {
      variants: [],
    },
    values: {
      title: null,
      state: 'active',
      images: [],
      image_ids: null,
      images_attributes: [],
      variant_ids: [],
    },
  }

  componentDidMount() {
    if (this.props.id) {
      this._loadAsyncData(this.props.id)
    }
    this.getProducts()
  }

  render () {
    const { title, id } = this.props
    const { values, kit, categories} = this.state

    return (
      <div className={page.gray}>
        <div className={page.title}>
          <h1>{kit ? `Редактирование образа` : 'Новый образ'}</h1>
        </div>

        <div className={classNames(form.root, form.tight)}>
          <form onSubmit={this.handleSubmit}>

            <div className={form.input}>
              <div className={form.label}>
                Название
              </div>

              <div className={form.input_input}>
                <input type="text" value={values.title} name="title" onChange={this.handleInputChange} />
              </div>
            </div>

            {kit && kit.variants &&
              <div className={form.input}>
                <div className={form.label}>Товары в образе</div>
                <div className={control.kit_variants}>
                  {kit.variants.map(variant =>
                    <div key={variant.id}>{variant.title}</div>
                  )}
                </div>
              </div>
            }
            {categories &&
              categories.map((category, index) =>
                <div key={category.id} className={classNames(control.category, {[control.active]: category.active})}>
                  <div className={control.title} onClick={() => this.handleCategoryClick(category.id)}>
                    {category.title}
                    {kit && kit.variants && kit.variants.filter(v => v.category == category.id).length > 0 &&
                      <div className={control.selected}>({kit.variants.filter(v => v.category == category.id).length})</div>
                    }
                  </div>
                  <div className={control.variants}>
                    {category.variants &&
                      category.variants.map(variant =>
                        <div key={variant.id} className={classNames(control.item, {[control.active]: values.variant_ids.includes(variant.id)})} onClick={() => this.handleVariantClick(variant)}>
                          <div className={control.image}>
                            <div className={control.selected} />
                            <img src={variant.thumb}/>
                          </div>
                          <div>{variant.title}</div>
                        </div>
                      )
                    }
                  </div>
                </div>
              )
            }

            <div className={form.input}>
              <div className={form.label}>
                Изображения
              </div>
              <Images images={values.images} onImagesChange={this.handleImagesChange}/>
            </div>

            <div className={form.input}>
              <div className={form.input_input}>
                <div className={form.radio}>
                  <div className={form.label}>
                    Статус
                  </div>

                  <div className={form.options}>
                    <label>
                      <input type="radio" name="state" checked={'active' == values.state} value="active" onChange={this.handleInputChange} />
                      Активный
                    </label>

                    <label>
                      <input type="radio" name="state" checked={'archived' == values.state} value="archived" onChange={this.handleInputChange} />
                      Архив
                    </label>
                  </div>
                </div>
              </div>
            </div>

            <div>
              <input className={buttons.main} type="submit" value="Сохранить" disabled={!this.canSubmit()} />
            </div>
          </form>

        </div>
      </div>
    )
  }

  _loadAsyncData(id) {
    this._asyncRequest = axios.CancelToken.source();

    axios.get(path('edit_kit_path', {id: id, format: 'json' }), { authenticity_token: document.querySelector('[name="csrf-token"]').content})
      .then(res => {
        this.setState({
          kit: res.data.kit,
          values: {
            title: res.data.kit.title,
            state: res.data.kit.state,
            images: res.data.kit.images,
            image_ids: res.data.kit.images.map(i => i.id),
            variant_ids: res.data.kit.variants.map(v => v.id)
          }
        });

        this._asyncRequest = null;
      });
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

  canSubmit = () => {
    return (
      this.state.values.variant_ids
    );
  }

  handleCategoryClick = (id) => {
    let key = this.state.categories.findIndex(c => c.id == id)

    const categories = update(this.state.categories, {
      [key]: {
        active: {
          $set: !this.state.categories[key].active
        }
      }
    });

    this.setState(state => ({
      categories: categories
    }))
  }

  handleVariantClick = (variant) => {
    let variants = this.state.kit.variants

    if (variants.map(v => v.id).includes(variant.id)) {
      variants = variants.filter(v => v.id !== variant.id)
    }
    else {
      variants.push(variant)
    }

    this.setState(state => ({
      values: { ...state.values,
        variant_ids: variants.map(v => v.id)
      },
      kit: { ...state.kit,
        variants: variants
      }
    }))
  }

  _handleUpdate = async () => {
    const res = await axios.patch(
      path('kit_path', { id: this.props.id }),
      { kit: this.state.values, authenticity_token: document.querySelector('[name="csrf-token"]').content }
    )

    if(res.headers.location) window.location = res.headers.location
  }

  _handleCreate = async () => {
    const res = await axios.post(
      path('kits_path'),
      { kit: this.state.values, authenticity_token: document.querySelector('[name="csrf-token"]').content }
    )

    if(res.headers.location) window.location = res.headers.location
  }

  getProducts = inputValue => {
    return axios.get(
      path('list_variants_path', {format: 'json' }), { params: { q: inputValue } }).then(res => {
        this.setState({
          categories: res.data.categories
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
