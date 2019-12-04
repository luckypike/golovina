import React from 'react'
import PropTypes from 'prop-types'

import Item from './Item'

import styles from './List.module.css'

List.propTypes = {
  subscribers: PropTypes.array
}

export default function List ({ subscribers }) {
  return (
    <div className={styles.root}>
      {subscribers.map(subscriber =>
        <Item key={subscriber.id} subscriber={subscriber} />
      )}
    </div>
  )
}
