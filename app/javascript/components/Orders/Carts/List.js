import React from 'react'
import PropTypes from 'prop-types'

import Item from './Item'

import styles from './List.module.css'

List.propTypes = {
  carts: PropTypes.array
}

export default function List ({ carts }) {
  return (
    <div className={styles.root}>
      {carts.map(cart =>
        <Item key={cart.id} cart={cart} />
      )}
    </div>
  )
}
