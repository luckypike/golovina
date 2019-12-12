import React, { Component } from 'react'
import axios from 'axios'
import classNames from 'classnames'

import { path } from '../Routes'
import I18n from '../I18n'

import Auth from './Auth'

import page from '../Page'
import buttons from '../Buttons'
import form from '../Form.module.css'
import styles from './Login.module.css'

class Login extends Component {
  state = {
    messages: {},
    section: 'email',
    // section: 'code',
    values: {
      code: '',
      email: '',
      phone: '',
      password: ''
    }
  }

  handleRecoverySubmit = async e => {
    e.preventDefault()

    await axios.post(
      path('recovery_user_session_path', { format: 'json' }),
      { user: { email: this.state.values.email }, authenticity_token: document.querySelector('[name="csrf-token"]').content }
    ).then(res => {
      this.setState({ section: 'recovered', messages: {}})
    }).catch(({ response }) => {
      this.setState({ messages: { recovery: response.data.message }})
    })
  }

  handleEmailSubmit = async e => {
    e.preventDefault()

    await axios.post(
      path('user_session_path', { format: 'json' }),
      { user: { email: this.state.values.email, password: this.state.values.password }, authenticity_token: document.querySelector('[name="csrf-token"]').content }
    ).then(res => {
      if(res.headers.location) window.location = res.headers.location
    }).catch(({ response }) => {
      this.setState({ messages: { email: response.data.message }})
    })
  }

  handlePhoneSubmit = async e => {
    e.preventDefault()

    if(this.isCode()) {
      await axios.post(
        path('code_user_session_path', { format: 'json' }),
        { user: { phone: this.state.values.phone, code: this.state.values.code }, authenticity_token: document.querySelector('[name="csrf-token"]').content }
      ).then(res => {
        if(res.headers.location) window.location = res.headers.location
      }).catch(({ response }) => {
        this.setState({ messages: { code: response.data.message }})
      })
    } else {
      await axios.post(
        path('phone_user_session_path', { format: 'json' }),
        { user: { phone: this.state.values.phone }, authenticity_token: document.querySelector('[name="csrf-token"]').content }
      ).then(res => {
        this.setState({ section: 'code', messages: {} })
      }).catch(({ response }) => {
        this.setState({ messages: { phone: response.data.message }})
      })
    }
  }

  handleInputChange = event => {
    const target = event.target
    const value = target.value
    const name = target.name

    this.setState(state => ({
      values: { ...state.values, [name]: value }
    }))
  }

  isRecovery() {
    return this.state.section == 'recovery' || this.isRecovered()
  }

  isRecovered() {
    return this.state.section == 'recovered'
  }

  isCode() {
    return this.state.section == 'code'
  }

  render () {
    const { section, values, messages } = this.state

    return (
      <div className={page.root}>
        <div className={page.title}>
          <h1>
            {I18n.t('login')}
          </h1>
        </div>

        <div className={form.tight}>
          <div className={styles.form}>
            {!this.isRecovery() &&
              <form onSubmit={this.handleEmailSubmit}>
                <label className={form.el}>
                  <div className={form.label}>
                    {I18n.t('session.email')}
                  </div>

                  <div className={form.input}>
                    <input type="email" value={values.email} name="email" onChange={this.handleInputChange} />
                  </div>
                </label>

                <label className={form.el}>
                  <div className={form.label}>
                    {I18n.t('session.password')}
                  </div>

                  <div className={form.input}>
                    <input type="password" value={values.password} name="password" onChange={this.handleInputChange} />
                  </div>

                  {messages.email &&
                    <div className={form.error}>
                      {messages.email}
                    </div>
                  }
                </label>

                <div className={classNames(form.submit, styles.submit)}>
                  <input className={buttons.main} type="submit" value={I18n.t('session.submit')} />

                  <div className={styles.recovery}>
                    <span id="recovery" onClick={() => this.setState({ section: 'recovery' })}>{I18n.t('session.recovery')}</span>
                  </div>
                </div>
              </form>
            }

            {this.isRecovery() &&
              <div className={styles.form}>
                {this.isRecovered() &&
                  <div className={styles.desc}>
                    Вам на почту выслано письмо с инструкцией по восстановлению доступа
                  </div>
                }

                {!this.isRecovered() &&
                  <form onSubmit={this.handleRecoverySubmit}>
                    <label className={form.el}>
                      <div className={form.label}>
                        {I18n.t('session.email')}
                      </div>

                      <div className={form.input}>
                        <input type="email" value={values.email} name="email" onChange={this.handleInputChange} />
                      </div>

                      {messages.recovery &&
                        <div className={form.error}>
                          {messages.recovery}
                        </div>
                      }
                    </label>

                    <div className={classNames(form.submit, styles.submit)}>
                      <input className={buttons.main} type="submit" value={I18n.t('session.reset')} />
                    </div>

                  </form>
                }
              </div>
            }
          </div>

          <div className={styles.sep}>{I18n.t('session.or')}</div>

          <Auth appleid={this.props.appleid} text={I18n.t('session.appleid')} />

          {/* <div className={styles.sep}>{I18n.t('session.or')}</div>

          <div className={styles.form}>
            <form onSubmit={this.handlePhoneSubmit}>
              <div className={styles.desc}>
                {I18n.t('session.sms')}
              </div>

              <label className={form.el}>
                <div className={form.label}>
                  {I18n.t('session.phone')}
                </div>

                <div className={form.input}>
                  <input type="text" value={values.phone} name="phone" onChange={this.handleInputChange} disabled={this.isCode()} />
                </div>

                {messages.phone &&
                  <div className={form.error}>
                    {messages.phone}
                  </div>
                }
              </label>

              {this.isCode() &&
                <label className={form.el}>
                  <div className={form.label}>
                    {I18n.t('session.code')}
                  </div>

                  <div className={form.input}>
                    <input type="text" value={values.code} name="code" onChange={this.handleInputChange} />
                  </div>

                  {messages.code &&
                    <div className={form.error}>
                      {messages.code}
                    </div>
                  }
                </label>
              }

              <div className={form.submit}>
                <input className={buttons.main} type="submit" value={this.isCode() ? I18n.t('session.confirm') : I18n.t('session.request')} />
              </div>
            </form>
          </div> */}
        </div>
      </div>
    )
  }
}

export default Login
