import React, { Component } from 'react'
import axios from 'axios'

import { path } from '../Routes'

import page from '../Page.module.css'
import styles from '../Form.module.css'

class ProductForm extends React.Component {
  state = {
    values: {
      title: '',
      category_id: ''
    },
    categories: [],
  }

  componentDidMount() {
    this._loadAsyncData();
  }

  static getDerivedStateFromProps(props, state) {
    if(props.values && (!state.values.title && !state.values.category_id)) {
      return {
        values: props.values
      };
    }

    return null;
  }

  componentDidUpdate(prevProps, prevState) {
    if(this.props.onChange) {
      if (this.state.values !== prevState.values) {
        this.props.onChange(this.state.values);
      }
    }
  }

  render () {
    const { title, category_id } = this.state.values
    const { categories } = this.state

    return (
      <form className={styles.form} onSubmit={this.handleSubmit}>
        <div className={styles.input}>
          <div className={styles.label}>
            Название
          </div>

          <div className={styles.input_input}>
            <input type="text" value={title} name="title" onChange={this.handleInputChange} />
          </div>
        </div>

        <div className={styles.input}>
          <div className={styles.label}>
            Категория
          </div>

          <div className={styles.input_input}>
            <select name="category_id" onChange={this.handleInputChange} value={category_id}>
              <option />
              {categories.map(category =>
                <option key={category.id} value={category.id}>{category.title}</option>
              )}
            </select>
          </div>
        </div>
      </form>
    )
  }

  _loadAsyncData() {
    this._asyncRequest = axios.CancelToken.source();

    axios.get(path('categories_path', { format: 'json' }), { authenticity_token: document.querySelector('[name="csrf-token"]').content})
      .then(res => {
        this.setState({
          categories: res.data.categories,
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
}

export default ProductForm
