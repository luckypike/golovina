import React, { Component } from 'react'
import PropTypes from 'prop-types'
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
    const { order, link } = this.props
    const { toggle } = this.state

    return (
      <div className={styles.order}>
        <div className={styles.handle} onClick={() => this.setState(state => ({ toggle: !state.toggle }))}>
          <svg viewBox="0 0 10 20" className={classNames(styles.arr, { [styles.active]: toggle })}>
            <polyline points="1 8 5 12 9 8" />
          </svg>

          <div className={styles.title}>
            <div className={classNames(styles.status, styles[order.state])}>
              {I18n.t(`order.state.${order.state}`)}
            </div>

            <div className={styles.number}>
              № {order.number}
            </div>

            <div className={styles.created_at}>
              {order.created_at}
            </div>
          </div>

          <div className={styles.what}>
            {I18n.t('order.quantity', { count: order.quantity, amount: currency(parseFloat(order.amount)) })}
          </div>

          {order.editable && order.state === 'paid' &&
            <div className={styles.archive}>
              <div className={buttons.main} onClick={() => this.handleUpdate(order.id)}>
                В архив
              </div>
            </div>
          }
        </div>

        {order.items.filter(item => !item.available).length === 0 && order.purchasable &&
          <div className={styles.pay}>
            <a href={path('pay_order_path', { id: order.id })} className={buttons.main}>
              Оплатить
            </a>
          </div>
        }

        {toggle &&
          <>
            <div className={styles.details}>
              Получатель: {order.user.title}
              <br />
              Телефон: {link ? <a href={`tel:${order.user.phone}`}>{order.user.phone}</a> : order.user.phone}
              <br />
              {order.delivery && order.delivery === 'russia' &&
                <>
                  <p>
                    Доставка: {order.delivery_city.title} ({order.delivery_city[order.delivery_option]} руб.)
                    <br />
                    {order.delivery_option === 'storage' && 'Точка выдачи' }
                    {order.delivery_option === 'door' && `Адрес: ${order.address}` }
                  </p>
                </>
              }

              {!order.delivery && 'Самовывоз'}
            </div>

            <div className={styles.items}>
              {order.items.map(item =>
                <div className={styles.item} key={item.id}>
                  <div className={styles.image}>
                    {item.variant.images.length > 0 &&
                      <img src={item.variant.images[0].thumb} />
                    }
                  </div>

                  <div className={styles.title}>
                    {item.variant.title}
                  </div>

                  <div className={styles.price}>
                    <Price sell={parseFloat(item.variant.price_sell)} origin={parseFloat(item.variant.price)} />
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
      this.props.onOrderChange(id)
    })
  }
}

Item.propTypes = {
  order: PropTypes.object,
  onOrderChange: PropTypes.func,
  link: PropTypes.bool
}

class List extends Component {
  static defaultProps = {
    link: false
  }

  render () {
    const { orders, states, link } = this.props

    return (
      <div className={styles.root}>
        {states &&
          <div className={styles.states}>
            {states.map((status, _) =>
              <div key={_} className={classNames(styles.state, { [styles.active]: this.props.status === status.key })} onClick={() => this.props.onStateChange(status.key)}>
                {status.title}
              </div>
            )}
            <a href={path('refunds_path')} className={styles.state}>
              Возврат
            </a>
          </div>
        }
        {orders.map(order =>
          <Item key={order.id} link={link} order={order} onOrderChange={this.props.onOrderChange}/>
        )}
      </div>
    )
  }
}

List.propTypes = {
  status: PropTypes.string,
  orders: PropTypes.array,
  states: PropTypes.array,
  onStateChange: PropTypes.func,
  onOrderChange: PropTypes.func,
  link: PropTypes.bool
}

export default List
