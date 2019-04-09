import React, { Component } from 'react'
import classNames from 'classnames'

import styles from './Price.module.css'

class Price extends Component {
  render () {
    const { sell, origin } = this.props

    return (
      <div className={styles.root}>
        <div className={classNames(styles.sell, this.props.sellClass, { [styles.last]: origin && sell != origin })}>
          {currency(sell)}
        </div>

        {origin && sell != origin &&
          <div className={classNames(styles.origin, this.props.originClass)}>
            {currency(origin)}
          </div>
        }
      </div>
    )
  }
}

Price.defaultProps = {
  value: 0,
  prev: null
}

const currency = (source) => {
  let formatter = new Intl.NumberFormat('ru-RU', {
    minimumFractionDigits: Math.round(source) == source ? 0 : 2,
    maximumFractionDigits: Math.round(source) == source ? 0 : 2,
  })

  let value = formatter.format(source)
  if(source < 10000) value = value.replace(/\s/, '')
  return `${value} ₽`
}

export { Price as default, currency }
