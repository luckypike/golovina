import React, { Component } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

import { path } from '../Routes'

import styles from './List.module.css'

class Item extends Component {
  state = {
    toggle: false
  }

  render() {
    const { toggle } = this.state
    const { color } = this.props

    console.log(color);

    return(
        <div className={styles.parent_color} onClick={() => this.setState(state => ({ toggle: !state.toggle }))}>
          <div className={styles.parent_title}>
            <a href={path('edit_color_path', { id: color.id })}>
              {color.title}
            </a>
          </div>

          {toggle && color.child_color.length != 0 &&
            <div className={styles.child_color}>
              {color.child_color.map(i =>
                <div key={i.id} className={classNames(styles.child_title, {[styles.active]: toggle})} >
                  <a href={path('edit_color_path', { id: i.id })}>
                    — {i.title}
                  </a>
                </div>
              )}
            </div>
          }
        </div>
    )
  }
}

Item.propTypes = {
  color: PropTypes.object,
}

class List extends Component {
  render() {
    const { colors } = this.props

    return(
      <div className={styles.root}>
        {colors.map(color =>
          <Item key={color.id} color={color} />
        )}
      </div>
    )
  }
}

List.propTypes = {
  colors: PropTypes.array,
}

export default List
