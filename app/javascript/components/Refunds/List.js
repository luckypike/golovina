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
    const { refund, link } = this.props
    const { toggle } = this.state

    return (
      <div className={styles.refund}>
        <div className={styles.handle}>
          <div className={styles.title} onClick={() => this.setState(state => ({ toggle: !state.toggle }))}>
            <div className={classNames(styles.status, styles[refund.state])}>
              {I18n.t(`refund.state.${refund.state}`)}
            </div>

            <div className={styles.number}>
              № {refund.order_id}
            </div>

            <div className={styles.created_at}>
              {refund.created_at}
            </div>
          </div>

          <div className={styles.what} onClick={() => this.setState(state => ({ toggle: !state.toggle }))}>
            {I18n.t('refund.quantity', { count: refund.quantity, amount: currency(refund.amount) })}
          </div>

          {refund.editable && refund.state !== 'done' &&
            <div className={styles.done}>
              <div className={buttons.main} onClick={() => this.handleUpdate(refund.id)}>
                Завершить
              </div>
            </div>
          }
        </div>

        {toggle &&
          <>
            <div className={styles.details}>
              Получатель: {refund.user.title}
              <br />
              Телефон: {link ? <a href={`tel:${refund.user.phone}`}>{refund.user.phone}</a> : refund.user.phone}
              <br />
              Адрес: {refund.address}
              <br />
              Причина возврата: {I18n.t(`refund.reason.${refund.reason}`)}

              {refund.reason === 'other' &&
                <>
                  <br />
                  Описание: {refund.detail}
                </>
              }
            </div>

            <div className={styles.items}>
              {refund.items.map(item =>
                <div className={styles.item} key={item.id}>
                  <div className={styles.image}>
                    {item.variant.images.length > 0 &&
                      <img src={item.variant.images[0].thumb} />
                    }
                  </div>

                  <div className={styles.title}>
                    {item.variant.title}
                  </div>

                  <div className={styles.color}>
                    <Price sell={item.price} />
                  </div>

                  <div className={styles.color}>
                    Цвет: {item.color.title}
                  </div>

                  <div className={styles.size}>
                    Размер: {item.size.title}
                  </div>

                  {refund.purchasable &&
                    <div className={classNames(styles.quantity, { [styles.unavailable]: !item.available })}>
                      Количество: {item.quantity} {!item.available ? ` (доступно: ${item.quantity_available})` : null}
                    </div>
                  }

                  {!refund.purchasable &&
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
      path('done_refund_path', { id: id }),
      { authenticity_token: document.querySelector('[name="csrf-token"]').content }
    ).then(res => {
      this.props.onRefundChange(id)
    })
  }
}

Item.propTypes = {
  refund: PropTypes.object,
  onRefundChange: PropTypes.func,
  link: PropTypes.bool
}

class List extends Component {
  static defaultProps = {
    link: false
  }

  render () {
    const { refunds, states, link } = this.props

    return (
      <div className={styles.root}>
        {states &&
          <div className={styles.states}>
            {states.map((status, _) =>
              <div key={_} className={classNames(styles.state, { [styles.active]: this.props.status === status.key })} onClick={() => this.props.onStateChange(status.key)}>
                {status.title}
              </div>
            )}
          </div>
        }
        {refunds.map(refund =>
          <Item key={refund.id} link={link} refund={refund} onRefundChange={this.props.onRefundChange}/>
        )}
      </div>
    )
  }
}

List.propTypes = {
  refunds: PropTypes.array,
  onRefundChange: PropTypes.func,
  link: PropTypes.bool
}

export default List
