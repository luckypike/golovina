import React, { Component } from 'react'
import classNames from 'classnames'
import axios from 'axios'

import { path } from '../Routes'
import I18n from '../I18n'
import Price, { currency } from '../Variants/Price'

import styles from './List.module.css'
import buttons from '../Buttons.module.css'

class Item extends Component {
  state = {
    toggle: false
  }

  render () {
    const { order } = this.props
    const { toggle } = this.state

    return (
      <div className={styles.order}>
        <div className={styles.handle}>
          <div className={styles.title} onClick={() => this.setState(state => ({ toggle: !state.toggle }))}>
            <div className={classNames(styles.status, styles[order.state])}>
              {I18n.t(`order.state.${order.state}`)}
            </div>

            <div className={styles.number}>
              № {order.number}
            </div>

            <div className={styles.created_at}>
              {order.created_at}
            </div>
          </div>

          <div className={styles.what} onClick={() => this.setState(state => ({ toggle: !state.toggle }))}>
            {I18n.t('order.quantity', { count: order.quantity, amount: currency(order.amount) })}
          </div>

          {order.state == 'paid' &&
            <div className={styles.archived}>
              <div className={buttons.main} onClick={() => this.handleUpdate(order.id)}>
                В архив
              </div>
            </div>
          }
        </div>

        {toggle &&
          <>
            <div className={styles.details}>
              Получатель: {order.user.title}
              <br />
              Телефон: {order.user.phone}
              <br />
              Адрес: {order.address}
            </div>

            {order.items.filter(item => !item.available).length == 0 && order.purchasable &&
              <div className={styles.pay}>
                <a href={path('pay_order_path', { id: order.id })} className={buttons.main}>
                  Оплатить
                </a>
              </div>
            }

            <div className={styles.items}>
              {order.items.map(item =>
                <div className={styles.item} key={item.id}>
                  <div className={styles.image}>
                    <img src={item.variant.image} />
                  </div>

                  <div className={styles.title}>
                    {item.variant.title}
                  </div>

                  <div className={styles.color}>
                    <Price sell={item.variant.price_sell} origin={item.variant.price} />
                  </div>

                  <div className={styles.color}>
                    Цвет: {item.color.title}
                  </div>

                  <div className={styles.size}>
                    Размер: {item.size.title}
                  </div>

                  {order.purchasable &&
                    <div className={classNames(styles.quantity, { [styles.unavailable]: !item.available })}>
                      Количество: {item.quantity} {!item.available ? ` (доступно: ${item.quantity_available})` : null}
                    </div>
                  }

                  {!order.purchasable &&
                    <div className={styles.quantity}>
                      Количество: {item.quantity}
                    </div>
                  }
                </div>
              )}
            </div>
          </>
        }
      </div>
    )
  }

  handleUpdate = (id) => {
    axios.post(
      path('archive_order_path', { id: id }),
      { authenticity_token: document.querySelector('[name="csrf-token"]').content }
    ).then(res => {
      this.props.onOrderChange(id);
    })
  }
}


class List extends Component {
  render () {
    const { orders, states } = this.props

    return (
      <div className={styles.root}>
        {states &&
          <div className={styles.states}>
            {states.map((status, _) =>
              <div key={_} className={classNames(styles.state, { [styles.active]: this.props.status == status.key})} onClick={()=>this.props.onStateChange(status.key)}>
                {status.title}
              </div>
            )}
          </div>
        }
        {orders.map(order =>
          <Item key={order.id} order={order} onOrderChange={this.props.onOrderChange}/>
        )}
      </div>
    )
  }
}

export default List
