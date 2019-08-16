import React, { useEffect, useState } from 'react'
import axios from 'axios'
import update from 'immutability-helper'
import classNames from 'classnames'

import { path } from '../Routes'

import Price, { currency } from '../Variants/Price'

import page from '../Page'
import styles from './Refund.module.css'
import form from '../Form.module.css'
import buttons from '../Buttons.module.css'

class Form extends React.Component {
  state = {
    order: this.props.order,
    values: {
      order_id: this.props.order.id,
      order_item_ids: [],
      reason: '',
      detail: '',
    }
  }

  static getDerivedStateFromProps(props, state) {
    if(props.order.id !== state.order.id) {
      return {
        order: props.order,
        values: {
          order_id: props.order.id,
        }
      };
    }

    return null;
  }

  handleSelect = (item) => {
    if (!item.refund) {
      let key = this.state.order.items.findIndex(i => i.id == item.id)

      const items = update(this.state.order.items, {
        [key]: {
          selected: {
            $set: !this.state.order.items[key].selected
          }
        }
      });

      this.setState(state => ({
        order: { ...state.order, items: items},
        values: { ...state.values, order_item_ids: items.filter(i => i.selected === true).map(i => i.id)}
      }))
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

  canSubmit = () => {
    return (
      this.state.values.reason
    )
  }

  handleSubmit = event => {
    this._handleCreate()

    event.preventDefault()
  }

  _handleCreate = async () => {
    const res = await axios.post(
      path('refunds_path'),
      { refund: this.state.values, authenticity_token: document.querySelector('[name="csrf-token"]').content }
    )

    if (res.headers.location) window.location = res.headers.location
  }

  canSubmit = () => {
    return (
      this.state.values.reason &&
      this.state.values.order_item_ids.length > 0
    )
  }

  render () {
    const { items } = this.state.order
    const { reason, detail } = this.state.values

    return (
      <div>
        <div className={form.label}>
          Отметьте товары для возврата
        </div>
        <div className={styles.items}>
          {items.map(item =>
            <div className={styles.item} key={item.id} onClick={() => this.handleSelect(item)}>
              {item.refund &&
                <div className={styles.refund}>
                  <div>На данный товар уже составлена заявка на возврат</div>
                </div>
              }
              <div className={styles.check}>
                <div className={form.checkbox}>
                  <label>
                    <input type="checkbox" name="latest" checked={item.selected} onChange={() => this.handleSelect(item)}/>
                  </label>
                </div>
              </div>

              <div className={styles.image}>
                {item.variant.images.length > 0 &&
                  <img src={item.variant.images[0].thumb} />
                }
              </div>

              <div className={styles.title}>
                {item.variant.title}
              </div>

              <div className={styles.color}>
                <Price sell={item.price_sell} />
              </div>

              <div className={styles.color}>
                Цвет: {item.color.title}
              </div>

              <div className={styles.size}>
                Размер: {item.size.title}
              </div>
            </div>
          )}
        </div>

        <form className={form.form} onSubmit={this.handleSubmit}>
          <div className={form.input}>
            <div className={form.label}>
              Укажите причину возврата
            </div>

            <div className={form.input_input}>
              <select name="reason" onChange={this.handleInputChange} value={reason}>
                {!reason &&
                  <option />
                }
                <option key={1} value="sizes">Не подошел размер</option>
                <option key={2} value="defect">Вещь имеет дефект</option>
                <option key={3} value="color">Не соответсвует цвет</option>
                <option key={0} value="other">Другая причина</option>
              </select>
            </div>
          </div>

          {reason && reason === 'other' &&
            <div className={form.input}>
              <div className={form.label}>
                Опишите причину
              </div>

              <div className={form.input_input}>
                <textarea value={detail} name="detail" rows="2" onChange={this.handleInputChange} />
              </div>
            </div>
          }

          <div>
            <input className={buttons.main} type="submit" value="Оформить" disabled={!this.canSubmit()}/>
          </div>
        </form>
      </div>
    );
  }
}

export default function Refund (props) {
  const [orders, setOrders] = useState()
  const [active, setActive] = useState(false)

  useEffect(() => {
    const _loadAsyncData = async () => {
      const { data: { orders } } = await axios.get(path('service_refund_path', { format: 'json' }))
      setOrders(orders)
    }

    _loadAsyncData()
  }, [])

  return (
    <div className={page.gray}>
      <div className={page.title}>
        <h1>Возврат товара</h1>
      </div>

      <div className={form.tight}>
        {orders && orders.length === 0 &&
          <div>У вас пока нет заказов</div>
        }

        {orders && orders.length > 0 &&
          <div className={form.input}>
            <div className={form.label}>
              Выберите номер заказа, товары которого вы хотите вернуть
            </div>

            <div className={form.input_input}>
              <select name="order_id" onChange={(option) => setActive(orders.find(order => order.id === parseInt(option.target.value)))} value={active.id}>
                {!active &&
                  <option />
                }
                {orders.map(order =>
                  <option key={order.id} value={order.id}>{order.id}</option>
                )}
              </select>
            </div>
          </div>
        }

        {active &&
          <Form order={active}/>
        }
      </div>
    </div>
  )
}
