import React, { Component } from 'react'
import axios from 'axios'
import classNames from 'classnames'
import update from 'immutability-helper'

import { path } from '../Routes'

import ProductForm from './ProductForm'
import Images from '../Images/Images'

import buttons from '../Buttons.module.css'
import page from '../Page.module.css'
import form from '../Form.module.css'
import styles from './Variant.module.css'

class Form extends React.Component {
  state = {
    variant: null,
    values: {
      color_id: '',
      state: 'active',
      created_at: null,
      updated_at: null,
      latest: false,
      sale: false,
      soon: false,
      pinned: false,
      desc: '',
      comp: '',
      price: '',
      price_last: '',
      product_id: this.props.product ? this.props.product.id : [],
      product_attributes: this.props.product || null,
      availabilities_attributes: [],
      images: [],
      image_ids: null,
      images_attributes: [],

    },
    dictionaries: {
      colors: this.props.colors || [],
      stores: this.props.stores || [],
      sizes: this.props.sizes || [],
      categories: this.props.categories || [],
    },
  }

  componentDidMount() {
    if (this.props.id) {
      this._loadAsyncData(this.props.id);
    }
  }

  render () {
    const { title, id } = this.props
    const { values, variant} = this.state
    const { colors, stores, sizes, categories } = this.state.dictionaries

    return (
      <div className={page.gray}>
        <div className={page.title}>
          <h1>{variant ? `Редактирование: ${title}` : 'Новый товар'}</h1>
        </div>

        <div className={classNames(form.root, form.tight)}>
          <ProductForm values={values.product_attributes} onChange={this.handleProductChange} categories={categories}/>
          <form className={styles.variant_form} onSubmit={this.handleSubmit}>

            <div className={form.input}>
              <div className={form.input_input}>
                <div className={form.checkbox}>
                  <label>
                    <input disabled={values.sale} type="checkbox" name="latest" checked={values.latest} onChange={this.handleInputChange} />
                      new
                  </label>
                </div>
              </div>
            </div>

            <div className={form.input}>
              <div className={form.input_input}>
                <div className={form.checkbox}>
                  <label>
                    <input disabled={values.latest} type="checkbox" name="sale" checked={values.sale} onChange={this.handleInputChange} />
                      sale
                  </label>
                </div>
              </div>
            </div>

            <div className={form.input}>
              <div className={form.input_input}>
                <div className={form.checkbox}>
                  <label>
                    <input type="checkbox" name="soon" checked={values.soon} onChange={this.handleInputChange} />
                      Скоро в наличии
                  </label>
                </div>
              </div>
            </div>

            <div className={form.input}>
              <div className={form.input_input}>
                <div className={form.checkbox}>
                  <label>
                    <input type="checkbox" name="pinned" checked={values.pinned} onChange={this.handleInputChange} />
                      Закреплен
                  </label>
                </div>
              </div>
            </div>

            <div className={form.input}>
              <div className={form.label}>
                Цвет
              </div>

              <div className={form.input_input}>
                <select name="color_id" onChange={this.handleInputChange} value={values.color_id}>
                  <option />
                  {colors.map(color =>
                    <option key={color.id} value={color.id}>{color.title}</option>
                  )}
                </select>
              </div>
            </div>

            <div className={form.input}>
              <div className={form.label}>
                Артикул
              </div>

              <div className={form.input_input}>
                <input type="text" value={values.code} name="code" onChange={this.handleInputChange} />
              </div>
            </div>

            <div className={form.stores}>
              {stores.map((store, _) =>
                <>
                  <div className={form.store}>
                    <div className={form.input}>
                      <div className={form.label}>
                        Доступные размеры для {store.title}
                      </div>

                      <div className={styles.sizes}>
                        {sizes.sort((a, b) => a.weight - b.weight).map((size, _) =>
                          <div key={_} className={classNames([styles.size], {[styles.active]: values.availabilities_attributes.find(s => s.size_id == size.id && s.store_id == store.id && !s._destroy)})} onClick={() => this.handleSizesChange(store.id, size.id)}>{size.size}</div>
                        )}
                      </div>
                    </div>
                  </div>

                  {values.availabilities_attributes && values.availabilities_attributes.filter(s => s.store_id == store.id )&&
                    values.availabilities_attributes.filter(s => s.store_id == store.id && !s._destroy).sort((a, b) => a.weight - b.weight).map((size, key) =>
                      <div key={key} className={form.input}>
                        <div className={form.label}>
                          Количество размера "{sizes.find(s => s.id == size.size_id).size}"
                        </div>

                        <div className={form.input_input}>
                          <input type="text" value={size.quantity} name={`size[${size.size_id}]`} onChange={this.handleQuantityChange(store.id, size.size_id)} />
                        </div>
                      </div>
                    )
                  }
                </>
              )}
            </div>

            <div className={form.input}>
              <div className={form.label}>
                Стоимость
              </div>

              <div className={form.input_input}>
                <input type="text" value={values.price} name="price" onChange={this.handleInputChange} />
              </div>
            </div>

            <div className={form.input}>
              <div className={form.label}>
                Стоимость со скидкой
              </div>

              <div className={form.input_input}>
                <input type="text" value={values.price_last} name="price_last" onChange={this.handleInputChange} />
              </div>
            </div>

            <div className={form.input}>
              <div className={form.label}>
                Описание
              </div>

              <div className={form.input_input}>
                <textarea name="desc" value={values.desc} rows="2" onChange={this.handleInputChange} />
              </div>
            </div>

            <div className={form.input}>
              <div className={form.label}>
                Как ухаживать
              </div>

              <div className={form.input_input}>
                <textarea name="comp" value={values.comp} rows="2" onChange={this.handleInputChange} />
              </div>
            </div>

            <div className={form.el}>
              <label>
                <div className={form.label}>
                  Дата обновления
                </div>

                <div className={form.datetime}>
                  <div className={form.input}>
                    <input name="updated_at" type="datetime-local" value={values.updated_at} onChange={this.handleInputChange}/>
                  </div>
                </div>
              </label>
            </div>

            <div className={form.input}>
              <div className={form.label}>
                Изображения
              </div>
              <Images images={values.images} onImagesChange={this.handleImagesChange}/>
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

    axios.get(path('edit_variant_path', {id: id, format: 'json' }), { authenticity_token: document.querySelector('[name="csrf-token"]').content})
      .then(res => {
        this.setState({
          variant: res.data.variant,
          values: {
            color_id: res.data.variant.color_id,
            code: res.data.variant.code,
            state: res.data.variant.state,
            created_at: res.data.variant.created_at,
            updated_at: res.data.variant.updated_at,
            latest: res.data.variant.latest,
            sale: res.data.variant.sale,
            soon: res.data.variant.soon,
            pinned: res.data.variant.pinned,
            desc: res.data.variant.desc,
            comp: res.data.variant.comp,
            price: res.data.variant.price,
            price_last: res.data.variant.price_last,
            product_id: res.data.variant.product_attributes.id,
            product_attributes: res.data.variant.product_attributes,
            availabilities_attributes: res.data.variant.availabilities_attributes,
            images: res.data.variant.images,
            image_ids: res.data.variant.images.map(i => i.id)
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

  handleQuantityChange = (store, size) => (event) => {
    const target = event.target
    const value = target.value

    let key = Object.keys(this.state.values.availabilities_attributes).find(s => this.state.values.availabilities_attributes[s].size_id == size && this.state.values.availabilities_attributes[s].store_id == store);

    const availabilities = update(this.state.values.availabilities_attributes, {
      [key]: {
        quantity: {
          $set: value
        }
      }
    });

    this.setState(state => ({
      values: { ...state.values,
        availabilities_attributes: availabilities
      }
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
      this.state.values.product_attributes &&
      this.state.values.color_id &&
      this.state.values.price &&
      this.state.values.state
    );
  }

  _handleUpdate = async () => {
    const res = await axios.patch(
      path('variant_path', { id: this.props.id }),
      { variant: this.state.values, authenticity_token: document.querySelector('[name="csrf-token"]').content }
    )

    if(res.headers.location) window.location = res.headers.location
  }

  _handleCreate = async () => {
    const res = await axios.post(
      path('variants_path'),
      { variant: this.state.values, authenticity_token: document.querySelector('[name="csrf-token"]').content }
    )

    if(res.headers.location) window.location = res.headers.location
  }

  handleProductChange = (product) => {
    this.setState(state => ({
      values: { ...state.values,
        product_attributes: product,
        product_id: product.id,
      }
    }))
  }

  handleSizesChange = (store, size) => {
    if (this.state.values.availabilities_attributes.find(s => s.size_id == size && s.store_id == store)) {
      let key = Object.keys(this.state.values.availabilities_attributes).find(s => this.state.values.availabilities_attributes[s].size_id == size && this.state.values.availabilities_attributes[s].store_id == store);

      const availabilities = update(this.state.values.availabilities_attributes, {
        [key]: {
          _destroy: {
            $set: !this.state.values.availabilities_attributes[key]._destroy
          }
        }
      });

      this.setState(state => ({
        values: { ...state.values,
          availabilities_attributes: availabilities
        }
      }))
    }
    else {
      this.setState(state => ({
        values: { ...state.values,
          availabilities_attributes: [ ...state.values.availabilities_attributes, {
            store_id: store,
            size_id: size,
            variant_id: this.props.id,
            quantity: 0,
            weight: this.state.dictionaries.sizes.find(s => s.id == size).weight,
            _destroy: false
          }]
        }
      }))
    }
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
