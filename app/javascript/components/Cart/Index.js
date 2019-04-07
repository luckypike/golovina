import React, { Component } from 'react'
import axios from 'axios'
import classNames from 'classnames'

import { path } from '../Routes'
import Price from '../Variants/Price'

import page from '../Page'

import styles from './Index.module.css'
import form from '../Form.module.css'
import buttons from '../Buttons.module.css'

class Index extends Component {
  state = {
    errors: {},
    carts: null,
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

    // if(res.headers.location) window.location = res.headers.location
  }

  handleDestroyClick = async cart => {
    const res = await axios.delete(
      path('cart_destroy_path', { id: cart.id }),
      {
        params: {
          authenticity_token: this.token
        }
      }
    )

    this._loadAsyncData()
  }

  render () {
    const { carts, order, user, values, amount, errors } = this.state

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
              <p>
                Сумма заказа: {amount}
              </p>

              {carts.map(cart =>
                <div className={styles.cart} key={cart.id}>
                  <div className={styles.image}>
                    <img src={cart.variant.image} />
                  </div>

                  <div className={styles.title}>
                    {cart.variant.title}
                  </div>

                  <div className={styles.color}>
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
                <div className={form.item}>
                  <label className={form.label}>
                    Имя
                  </label>
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
                </div>

                <div className={form.item}>
                  <label className={form.label}>
                    Фамилия
                  </label>
                  <div className={form.input}>
                    <input type="text" name="s_name" value={values.s_name} onChange={this.handleInputChange} />
                  </div>
                </div>

                <div className={form.item}>
                  <label className={form.label}>
                    Телефон
                  </label>
                  <div className={form.input}>
                    <input type="text" name="phone" value={values.phone} onChange={this.handleInputChange} />
                  </div>

                  {errors['user.phone'] &&
                    <div className={form.error}>
                      <ul>
                        {errors['user.phone'].map((error, i) => <li key={i} dangerouslySetInnerHTML={{ __html: error }} /> )}
                      </ul>

                    </div>
                  }
                </div>

                <div className={form.item}>
                  <label className={form.label}>
                    Электронная почта
                  </label>
                  <div className={form.input}>
                    <input type="text" name="email" value={values.email} onChange={this.handleInputChange} />
                  </div>
                </div>

                <div className={form.item}>
                  <label className={form.label}>
                    Адрес доставки
                  </label>
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
                </div>

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
