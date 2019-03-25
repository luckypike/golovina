import React, { Component } from 'react'
import axios from 'axios'

import { path } from '../Routes'

import styles from './Form.module.css'
import page from '../Page'

class Form extends React.Component {
  render () {
    return (
      <div className={page.gray}>
        <div className={page.title}>
          <h1>Редактирование категории</h1>
        </div>

        <div className={styles.root}>
          FORM
        </div>
      </div>
    )
  }
}

export default Form
