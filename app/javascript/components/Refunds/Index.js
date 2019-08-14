import React, { useEffect, useState } from 'react'
import axios from 'axios'
import update from 'immutability-helper'
import classNames from 'classnames'

import { path } from '../Routes'

import List from '../Orders/List'
import Price, { currency } from '../Variants/Price'

import page from '../Page'
import styles from './Index.module.css'
import form from '../Form.module.css'
import buttons from '../Buttons.module.css'

class Refund extends React.Component {
  state = {
    order: this.props.order,
    values: {
      order_id: this.props.order.id,
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

  handleSelect = (id) => {
    let key = this.state.order.items.findIndex(i => i.id == id)

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
    // if (this.props.id) {
    //   this._handleUpdate()
    // } else {
      this._handleCreate()
    // }
    event.preventDefault()
  }

  _handleCreate = async () => {
    const res = await axios.post(
      path('refunds_path'),
      { refund: this.state.values, authenticity_token: document.querySelector('[name="csrf-token"]').content }
    )

    if (res.headers.location) window.location = res.headers.location
  }

  render () {
    const { items } = this.state.order
    const { reason, detail } = this.state.values

    return (
      <div>
        <div className={styles.items}>
          {items.map(item =>
            <div className={classNames(styles.item, { [styles.selected]: item.selected })} key={item.id} onClick={() => this.handleSelect(item.id)}>
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
                <option key={3} value="color">Не подошел цвет</option>
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
            <input className={buttons.main} type="submit" value="Сохранить" />
          </div>
        </form>
      </div>
    );
  }
}

export default function Index (props) {
  const [orders, setOrders] = useState()
  const [active, setActive] = useState(false)

  useEffect(() => {
    const _loadAsyncData = async () => {
      const { data: { orders } } = await axios.get(path('refunds_path', { format: 'json' }))
      setOrders(orders)
    }

    _loadAsyncData()
  }, [])

  return (
    <div className={page.gray}>
      <div className={page.title}>
        <h1>Возврат</h1>
      </div>

      {orders &&
        <div className={form.input}>
          <div className={form.label}>
            Выберите заказ. товары которого вы хотите вернуть
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
        <Refund order={active}/>
      }
    </div>
  )
}
