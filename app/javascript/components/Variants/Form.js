import React, { Component } from 'react'
import axios from 'axios'

import { path } from '../Routes'

import ProductForm from './ProductForm'

import buttons from '../Buttons.module.css'
import page from '../Page.module.css'
import styles from '../Form.module.css'

class Form extends React.Component {
  state = {
    values: this.props,
    colors: [],
  }

  componentDidMount() {
    if (this.props.id) {
      this._loadAsyncData(this.props.id);
    }
  }

  render () {
    const { title, id } = this.props
    const { values, colors } = this.state

    if (!values) return null;

    return (
      <div className={page.gray}>
        <div className={page.title}>
          <h1>Редактирование: {title}</h1>
        </div>

        <div className={styles.root}>
          <ProductForm values={values.product_attributes} onChange={this.handleProductChange}/>
          <form onSubmit={this.handleSubmit}>

            <div className={styles.input}>
              <div className={styles.label}>
                Цвет
              </div>

              <div className={styles.input_input}>
                <select name="color_id" onChange={this.handleInputChange} value={values.color_id}>
                  <option />
                  {colors.map(color =>
                    <option key={color.id} value={color.id}>{color.title}</option>
                  )}
                </select>
              </div>
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

    axios.get(path('edit_variant_path', {id: id, format: 'json' }), { authenticity_token: document.querySelector('[name="csrf-token"]').content})
      .then(res => {
        this.setState({
          values: res.data.variant,
          colors: res.data.colors,
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
    this._handleUpdate()
    event.preventDefault()
  }

  _handleUpdate = async () => {
    const res = await axios.patch(
      path('variant_path', { id: this.props.id }),
      { variant: this.state.values, authenticity_token: document.querySelector('[name="csrf-token"]').content }
    )

    if(res.headers.location) window.location = res.headers.location
  }

  handleProductChange = (product) => {
    this.setState(state => ({
      values: { ...state.values, product_attributes: product }
    }))
  }
}

export default Form
