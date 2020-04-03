import React, { useEffect, useState } from 'react'
import axios from 'axios'
import classNames from 'classnames'

import { path } from '../Routes'
import I18n from '../I18n'
import Form from './Form'

import page from '../Page'
import buttons from '../Buttons.module.css'
import styles from './Index.module.css'

class Promo extends React.Component {
  state = {
    promo: this.props.promo,
    edit: false
  }

  handleClose = () => {
    this.setState({ edit: false });
  }

  handleUpdate = (promo) => {
    this.setState({ promo: promo, edit: false });
  }

  render() {
    const { edit, promo } = this.state

    return (
      <div className={classNames([styles.promo], {[styles.edit]: edit})}>
        {edit ? (
          <Form promo={promo} onClose={this.handleClose} onUpdate={this.handleUpdate} />
        ) : (
          <div onClick={() => this.setState({ edit: true })}>
            <div className={styles.subject}>
              {promo.title_ru}
            </div>
          </div>
        )}
      </div>
    );
  }
}

export default function Index (props) {
  const [promos, setPromos] = useState()
  const [create, setCreate] = useState(false)

  useEffect(() => {
    const _loadAsyncData = async () => {
      const { data: { promos } } = await axios.get(path('promos_path', { format: 'json' }))
      setPromos(promos)
    }

    _loadAsyncData()
  }, [])

  return (
    <div className={page.root}>
      <div className={page.title}>
        <h1>{I18n.t('promos.title')}</h1>
      </div>

      <div className={styles.promos}>
        {create ? (
          <Form onClose={() => setCreate(false)} />
        ) : (
          <button className={buttons.main} onClick={() => setCreate(true)}>Новое предложение</button>
        )}

        {promos &&
          promos.map((promo) =>
            <Promo key={promo.id} promo={promo} />
          )
        }
      </div>
    </div>
  )
}
