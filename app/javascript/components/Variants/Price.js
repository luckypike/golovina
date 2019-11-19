import React, { Component } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

import styles from './Price.module.css'

class Price extends Component {
  render () {
    const { sell, origin } = this.props

    if (!sell) return null

    return (
      <div className={styles.root}>
        <div className={classNames(styles.sell, this.props.sellClass, { [styles.last]: origin && sell !== origin })}>
          {currency(sell)}
        </div>

        {origin && sell !== origin &&
          <div className={classNames(styles.origin, this.props.originClass)}>
            {currency(origin)}
          </div>
        }
      </div>
    )
  }
}

Price.defaultProps = {
  // prev: null
}

Price.propTypes = {
  sell: PropTypes.number,
  origin: PropTypes.number,
  sellClass: PropTypes.string,
  originClass: PropTypes.string
}

const currency = (source) => {
  let formatter = new Intl.NumberFormat('ru-RU', {
    minimumFractionDigits: Math.round(source) === source ? 0 : 2,
    maximumFractionDigits: Math.round(source) === source ? 0 : 2
  })

  let value = formatter.format(source)
  if ((source < 10000 && source > 0) || (source > -10000 && source < 0)) value = value.replace(/\s/, '')
  return `${value} ₽`
}

export { Price as default, currency }
