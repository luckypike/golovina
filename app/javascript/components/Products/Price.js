import React, { Component } from 'react'

class Price extends Component {
  toValue = source => {

    let formatter = new Intl.NumberFormat('ru-RU', {
      minimumFractionDigits: Math.round(source) == source ? 0 : 2,
      maximumFractionDigits: Math.round(source) == source ? 0 : 2,
    })

    let value = formatter.format(source)
    if(source < 10000) value = value.replace(/\s/, '')
    return `${value} ₽`
  }

  render () {
    const { value, prev } = this.props

    return (
      <>
        {this.toValue(value)}
      </>
    )
  }
}

Price.defaultProps = {
  value: 0,
  prev: null
}

export default Price
