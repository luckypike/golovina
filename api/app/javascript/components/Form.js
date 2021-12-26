import React, { useState, useRef, useCallback } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

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

export function useForm (initValues) {
  const cancelToken = useRef(axios.CancelToken.source())

  const prevPendingRef = useRef(false)
  const [pending, setPending] = useState(prevPendingRef.current)

  const prevErrorsRef = useRef({})
  const [errors, setErrors] = useState(prevErrorsRef.current)

  const prevSavedRef = useRef()
  const [saved, setSaved] = useState(prevSavedRef.current)

  const [values, setValues] = useState(initValues)

  const handleInputChange = ({ target: { name, value } }) => {
    setValues({ ...values, [name]: value })
  }

  const onSubmit = useCallback(
    handleSubmit => async e => {
      e.preventDefault()

      if (pending) {
        return null
      } else {
        // console.log('SET FIRST TIME')
        setErrors({})
        setPending(true)
        setSaved(false)
      }

      await handleSubmit(e)

      setPending(false)
    }
  )

  return {
    values,
    setValues,
    errors,
    setErrors,
    saved,
    setSaved,
    onSubmit,
    pending,
    cancelToken,
    handleInputChange
  }
}
