import React, { Component } from 'react'
import axios from 'axios'
import classNames from 'classnames'
import InputMask from 'react-input-mask'
import PubSub from 'pubsub-js'

import { path } from '../Routes'
import Price from '../Variants/Price'

import page from '../Page'

import styles from './Index.module.css'
import form from '../Form.module.css'
import buttons from '../Buttons.module.css'

class Index extends Component {
  state = {
    errors: {},
    carts: null
  }

  componentDidMount = async () => {
    this._loadAsyncData()
    this.token = document.querySelector('[name="csrf-token"]').content
  }

  _loadAsyncData = async () => {
    const res = await axios.get(path('cart_path', { format: 'json' }))
    this.setState({ ...res.data })
  }

  handleInputChange = event => {
    const target = event.target
    const value = target.type === 'checkbox' ? target.checked : target.value
    const name = target.name

    this.setState(state => ({
      values: { ...state.values, [name]: value }
    }))
  }

  handleSubmit = async (event) => {
    event.preventDefault()

    const res = await axios.post(
      path('orders_path'),
      {
        order: {
          user_attributes: (({ name, s_name, phone, email }) => ({ name, s_name, phone, email }))(this.state.values),
          address: this.state.values.address
        },
        authenticity_token: this.token
      }
    ).catch(({ response }) => {
      this.setState({ errors: response.data })
    })

    if(res.headers.location) window.location = res.headers.location
  }

  handleDestroyClick = async cart => {
    const { data: { quantity } } = await axios.delete(
      path('cart_destroy_path', { id: cart.id }),
      {
        params: {
          authenticity_token: this.token
        }
      }
    )

    PubSub.publish('update-cart', quantity)
    this._loadAsyncData()
  }

  render () {
    const { carts, order, user, values, amount, origin, errors } = this.state

    return (
      <div className={page.gray}>
        <div className={page.title}>
          <h1>Корзина</h1>
        </div>

        {carts && carts.length < 1 &&
          <div>
            В корзине пока ничего нет :(
          </div>
        }

        {carts && carts.length > 0 &&
          <div className={styles.root}>
            <div className={styles.carts}>
              <div className={styles.amount}>
                <div className={styles.sum}>Сумма заказа:</div>
                <Price sell={amount} origin={origin} />
            </div>

              {carts.map(cart =>
                <div className={styles.cart} key={cart.id}>
                  <div className={styles.image}>
                    {cart.variant.images.length > 0 &&
                      <img src={cart.variant.images[0].thumb} />
                    }
                  </div>

                  <div className={styles.title}>
                    {cart.variant.title}
                  </div>

                  <div className={styles.price}>
                    <Price sell={cart.variant.price_sell} origin={cart.variant.price} />
                  </div>

                  <div className={styles.color}>
                    Цвет: {cart.color.title}
                  </div>

                  <div className={styles.size}>
                    Размер: {cart.size.title}
                  </div>

                  <div className={classNames(styles.quantity, { [styles.unavailable]: !cart.available })}>
                    Количество: {cart.quantity} {!cart.available ? ` (доступно: ${cart.quantity_available})` : null}
                  </div>

                  <div className={styles.destroy} onClick={() => this.handleDestroyClick(cart)}>
                    Удалить из корзины
                  </div>
                </div>
              )}
            </div>

            <div className={styles.checkout}>
              <form className={classNames(form.root, styles.form)} onSubmit={this.handleSubmit}>
                <label className={form.el}>
                  <div className={form.label}>
                    Имя
                  </div>

                  <div className={form.input}>
                    <input type="text" name="name" value={values.name} onChange={this.handleInputChange} />
                  </div>

                  {errors['user.name'] &&
                    <div className={form.error}>
                      <ul>
                        {errors['user.name'].map((error, i) => <li key={i}>{error}</li>)}
                      </ul>

                    </div>
                  }
                </label>

                <label className={form.el}>
                  <div className={form.label}>
                    Фамилия
                  </div>

                  <div className={form.input}>
                    <input type="text" name="s_name" value={values.s_name} onChange={this.handleInputChange} />
                  </div>
                </label>

                <label className={form.el}>
                  <div className={form.label}>
                    Телефон
                  </div>

                  <div className={form.input}>
                    <InputMask type="text" name="phone" mask="+9 999 999 99 99" maskChar=" " value={values.phone} onChange={this.handleInputChange} />
                  </div>

                  {errors['user.phone'] &&
                    <div className={form.error}>
                      <ul>
                        {errors['user.phone'].map((error, i) => <li key={i} dangerouslySetInnerHTML={{ __html: error }} /> )}
                      </ul>

                    </div>
                  }
                </label>

                <label className={form.el}>
                  <div className={form.label}>
                    Электронная почта
                  </div>

                  <div className={form.input}>
                    <input type="text" name="email" value={values.email} onChange={this.handleInputChange} />
                  </div>

                  {errors['user.email'] &&
                    <div className={form.error}>
                      <ul>
                        {errors['user.email'].map((error, i) => <li key={i} dangerouslySetInnerHTML={{ __html: error }} /> )}
                      </ul>

                    </div>
                  }
                </label>

                <label className={form.el}>
                  <div className={form.label}>
                    Адрес доставки
                  </div>

                  <div className={form.input}>
                    <textarea type="text" name="address" value={values.address} onChange={this.handleInputChange} />
                  </div>

                  {errors.address &&
                    <div className={form.error}>
                      <ul>
                        {errors.address.map((error, i) => <li key={i}>{error}</li>)}
                      </ul>

                    </div>
                  }
                </label>

                {carts.filter(cart => !cart.available).length == 0 &&
                  <div className={form.submit}>
                    <input type="submit" value="Оплатить" className={buttons.main} />
                  </div>
                }
              </form>
            </div>
          </div>
        }
      </div>
    )
  }
}

export default Index
