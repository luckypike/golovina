import React, { useContext } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import axios from 'axios'

import { path } from '../../Routes'
import { I18nContext } from '../../I18n'
// import { useI18n } from '../../I18n'
import { useForm, Errors } from '../../Form'

import styles from './Tracker.module.css'
import form from '../../Form.module.css'
import buttons from '../../Buttons.module.css'

Tracker.propTypes = {
  order: PropTypes.object.isRequired
}

export default function Tracker ({ order }) {
  const I18n = useContext(I18nContext)

  const {
    values,
    setValues,
    // saved,
    // setSaved,
    handleInputChange,
    errors,
    pending,
    setErrors,
    onSubmit,
    cancelToken
  } = useForm({ tracker_type: null, tracker_id: '' })

  const handleSubmit = async e => {
    await axios.post(
      path('delivery_order_path', { id: order.id, format: 'json' }),
      { order: values },
      { cancelToken: cancelToken.current.token }
    ).then(res => {
      order.tracker_url = res.data.tracker_url
    }).catch(error => {
      setErrors(error.response.data)
    })
  }

  return (
    <div className={styles.root}>
      {order.tracker_url &&
        <div className={styles.tracker}>
          <a href={order.tracker_url} target="_blank" rel="noopener noreferrer">
            {order.tracker_url}
          </a>
        </div>
      }

      {!order.tracker_url &&
        <>
          {!values.tracker_type &&
            <div className={styles.type}>
              <button onClick={() => setValues({ ...values, tracker_type: 'cdek' })} className={buttons.main}>CDEK</button>
              <button onClick={() => setValues({ ...values, tracker_type: 'ems' })} className={buttons.main}>EMS</button>
              <button onClick={() => setValues({ ...values, tracker_type: 'ups' })} className={buttons.main}>UPS</button>
            </div>
          }

          {values.tracker_type &&
            <form className={classNames(form.root, styles.form)} onSubmit={onSubmit(handleSubmit)}>
              <div className={classNames(form.item, styles.id)}>
                <label>
                  <div className={form.label}>
                    {I18n.t(`order.tracker_id.${values.tracker_type}`)}
                  </div>

                  <div className={form.input}>
                    <input
                      type="text"
                      value={values.tracker_id}
                      name="tracker_id"
                      onChange={handleInputChange}
                    />
                  </div>
                </label>

                <Errors errors={errors.tracker_id} />
              </div>

              <div className={classNames(form.submit, styles.submit)}>
                <input
                  type="submit"
                  value={pending ? I18n.t('order.delivery.submitted') : I18n.t('order.delivery.submit')}
                  className={classNames(buttons.main, { [buttons.pending]: pending })}
                  disabled={pending || values.tracker_id === ''}
                />
              </div>
            </form>
          }
        </>
      }
    </div>
  )
}
