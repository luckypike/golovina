import React, { Component } from 'react'
import axios from 'axios'

import { path } from '../../Routes'

import page from '../../Page'
import buttons from '../../Buttons.module.css'
import styles from './Control.module.css'

class Control extends Component {
  state = {
    kits: null
  }

  componentDidMount = async () => {
    const res = await axios.get(path('kits_path', { format: 'json' }))
    this.setState({ ...res.data })
  }

  render () {
    const { kits } = this.state

    if(!kits) return null;

    return (
      <div className={page.gray}>
        <div className={page.title}>
          <h1>Все образы</h1>
        </div>

        <div className={styles.root}>
          <div className={styles.edit}>
            <a className={buttons.main} href={path('new_kit_path')}>Добавить образ</a>
          </div>

          <div className={styles.kits}>
            {kits.map((kit) =>
              <div className={styles.item} key={kit.id}>
                <div className={styles.image}>
                  <div className={styles.control}>
                    <a className={styles.edit} href={path('edit_kit_path', {id: kit.id})}/>
                  </div>
                  {kit.image &&
                    <img src={kit.image} />
                  }
                </div>
                <div className={styles.title}>
                  {kit.title}
                </div>
              </div>
            )}
          </div>
        </div>
      </div>
    )
  }
}

export default Control
