import React, { Component } from 'react'
import axios from 'axios'
import classNames from 'classnames'
import update from 'immutability-helper'

import { path } from '../Routes'

import Images from '../Images/Images'

import buttons from '../Buttons.module.css'
import page from '../Page.module.css'
import form from '../Form.module.css'

class Form extends React.Component {
  state = {
    promo: {
      id: null,
      title: '',
      link: '',
      popup: '',
      front: '',
    },
  }

  componentDidMount() {
    if (this.props.promo) {
      this._loadAsyncData(this.props.promo.id)
    }
  }

  render () {
    const { promo } = this.state

    return (
      <div>
        <div>
          <form onSubmit={this.handleSubmit}>

            <div className={form.input}>
              <div className={form.label}>
                Текст
              </div>

              <div className={form.input_input}>
                <input type="text" value={promo.title} name="title" onChange={this.handleInputChange} />
              </div>
            </div>

            <div className={form.input}>
              <div className={form.label}>
                Ссылка
              </div>

              <div className={form.input_input}>
                <input type="text" value={promo.link} name="link" onChange={this.handleInputChange} />
              </div>
            </div>

            <div className={form.input}>
              <div className={form.input_input}>
                <div className={form.checkbox}>
                  <label>
                    <input type="checkbox" name="popup" checked={promo.popup} onChange={this.handleInputChange} />
                      Всплывающее окно
                  </label>
                </div>
              </div>
            </div>

            <div className={form.input}>
              <div className={form.input_input}>
                <div className={form.checkbox}>
                  <label>
                    <input type="checkbox" name="front" checked={promo.front} onChange={this.handleInputChange} />
                      На главной
                  </label>
                </div>
              </div>
            </div>

            <div className={form.submit}>
              <button className={buttons.main} onClick={this.handleClose}>Отменить</button>
              <input className={buttons.main} type="submit" value="Сохранить" />
              {this.props.promo &&
                <button className={buttons.main} onClick={this.handleDestroy}>Удалить</button>
              }
            </div>
          </form>

        </div>
      </div>
    )
  }

  _loadAsyncData(id) {
    this._asyncRequest = axios.CancelToken.source();

    axios.get(path('edit_promo_path', {id: id, format: 'json' }), { authenticity_token: document.querySelector('[name="csrf-token"]').content})
      .then(res => {
        this.setState({
          promo: res.data.promo,
        });

        this._asyncRequest = null;
      });
  }

  handleInputChange = event => {
    const target = event.target
    const value = target.type === 'checkbox' ? target.checked : target.value
    const name = target.name

    this.setState(state => ({
      promo: { ...state.promo, [name]: value }
    }))
  }


  handleSubmit = event => {
    if (this.props.promo.id) {
      this._handleUpdate()
    }
    else {
      this._handleCreate()
    }
    event.preventDefault()
  }

  _handleUpdate = async () => {
    const res = await axios.patch(
      path('promo_path', { id: this.props.promo.id }),
      { promo: this.state.promo, authenticity_token: document.querySelector('[name="csrf-token"]').content }
    )

    if(res.headers.location) window.location = res.headers.location
  }

  _handleCreate = async () => {
    const res = await axios.post(
      path('promos_path'),
      { promo: this.state.promo, authenticity_token: document.querySelector('[name="csrf-token"]').content }
    )

    if(res.headers.location) window.location = res.headers.location
  }

  _handleUpdate = async () => {
    const res = await axios.patch(
      path('promo_path', { id: this.props.promo.id }),
      { promo: this.state.promo, authenticity_token: document.querySelector('[name="csrf-token"]').content }
    )

    if(res.headers.location) window.location = res.headers.location
  }

  handleDestroy = async () => {
    const res = await axios.delete(
      path('promo_path', { id: this.props.promo.id }),
      { params: { authenticity_token: document.querySelector('[name="csrf-token"]').content } }
    )

    if(res.headers.location) window.location = res.headers.location
  }

  handleClose = (e) => {
    if(this.props.onClose) this.props.onClose()
    e.preventDefault()
  }

}

export default Form
