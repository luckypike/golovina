import React, { Component } from 'react'
import axios from 'axios'
import classNames from 'classnames'

import { path } from '../../Routes'

import styles from './Control.module.css'

class KitItem extends React.Component {
  state = {
    deleting: false
  }

  render () {
    const { kit } = this.props

    return (
      <div className={styles.item} key={kit.id}>
        <div className={styles.image}>
          <div className={styles.control}>
            <a className={styles.edit} href={path('edit_kit_path', {id: kit.id})}/>
          </div>
          {kit.image &&
            <img src={kit.image} />
          }
          <div className={styles.control}>
            <div className={classNames([styles.a], [styles.destroy], {[styles.deleting]: this.state.deleting})} onClick={() => this.handeDelete(kit.id)}></div>
          </div>
        </div>
        <div className={styles.title}>
          {kit.title}
        </div>
      </div>
    )
  }

  handeDelete = async (id) => {
    this.setState({ deleting: true })

    const res = await axios.delete(
      path('kit_path', { id: id }), {params: { authenticity_token: document.querySelector('[name="csrf-token"]').content}}
    )

    if (this.props.onDelete) {
      axios.get(path('kits_path', { format: 'json' })).then(res => {
        this.props.onDelete(res.data.kits)
      })
    }
  }
}

export default KitItem
