import React from 'react'
import PropTypes from 'prop-types'

import form from './Form.module.css'

Errors.propTypes = {
  errors: PropTypes.array
}

export function Errors ({ errors }) {
  if (!errors) return null

  return (
    <div className={form.error}>
      <ul>
        {errors.map((error, _) => <li key={_}>{error}</li>)}
      </ul>
    </div>
  )
}
