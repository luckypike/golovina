import React, { Component } from 'react'
import axios from 'axios'
import classNames from 'classnames'

import { path } from '../Routes'
import I18n from '../I18n'

import page from '../Page'
import buttons from '../Buttons'
import form from '../Form'
import styles from './Login.module.css'

class Login extends Component {
  state = {
    section: 'email',
    values: {}
  }

  handleEmailSubmit = e => {
    e.preventDefault()
  }

  handlePhoneSubmit = e => {
    e.preventDefault()
  }

  render () {
    const { section, values } = this.state

    return (
      <div className={page.root}>
        <div className={page.title}>
          <h1>
            {I18n.t('login')}
          </h1>
        </div>

        <div className={form.tight}>
          {/*
          <div className={styles.tabs}>
            <div className={classNames(styles.tab, { [styles.active]: section == 'email' })} onClick={() => this.setState({ section: 'email' })}>
              Электронная почта
            </div>

            <div className={classNames(styles.tab, { [styles.active]: section == 'phone' })} onClick={() => this.setState({ section: 'phone' })}>
              Телефон
            </div>
          </div>
          */}

          <div className={styles.form}>
            <form onSubmit={this.handleEmailSubmit}>
              <label className={form.el}>
                <div className={form.label}>
                  Почта
                </div>

                <div className={form.input}>
                  <input type="text" value={values.email} name="email" onChange={this.handleInputChange} />
                </div>
              </label>

              <label className={form.el}>
                <div className={form.label}>
                  Пароль
                </div>

                <div className={form.input}>
                  <input type="password" value={values.password} name="password" onChange={this.handleInputChange} />
                </div>
              </label>

              <div className={form.submit}>
                <input className={buttons.main} type="submit" value="Войти" />
              </div>
            </form>
          </div>

          <div className={styles.sep}>Или</div>

          <div className={styles.form}>
            <form onSubmit={this.handlePhoneSubmit}>
              <div className={styles.desc}>
                Введите номер телефона, на него мы отправим SMS с кодом доступа к личному кабинету
              </div>

              <label className={form.el}>
                <div className={form.label}>
                  Телефон
                </div>

                <div className={form.input}>
                  <input type="text" value={values.phone} name="phone" onChange={this.handleInputChange} />
                </div>
              </label>

              <div className={form.submit}>
                <input className={buttons.main} type="submit" value="Получить код" />
              </div>
            </form>
          </div>
        </div>
      </div>
    )
  }
}

export default Login
