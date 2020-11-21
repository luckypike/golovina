import React from 'react'
import PropTypes from 'prop-types'
import Select from 'react-select'
import classNames from 'classnames'

import { Errors } from '../../Form'
import { useI18n } from '../../I18n'

import styles from './Address.module.css'
import form from '../../Form.module.css'

Address.propTypes = {
  errors: PropTypes.object,
  values: PropTypes.object,
  setValues: PropTypes.func,
  handleInputChange: PropTypes.func,
  dictionaries: PropTypes.object,
  locale: PropTypes.string
}

export default function Address ({ errors, values, handleInputChange, setValues, dictionaries, locale }) {
  const I18n = useI18n(locale)

  // const isPickup = () => values.delivery === 'pickup'
  const isRussia = () => values.delivery === 'russia'
  const isDoor = () => values.delivery_option === 'door'
  const isInternational = () => values.delivery === 'international'

  const isAddressable = () => {
    return isRussia() || isInternational()
  }

  if (!isAddressable()) return null

  const city = dictionaries.delivery_cities.find(city => city.id === values.delivery_city_id)

  return (
    <div className={styles.root}>
      <h2>
        {I18n.t('order.cart.shipping.address.title')}
      </h2>

      {isRussia() &&
        <div className={form.item}>
          <label>
            <div className={form.label}>
              Населенный пункт
            </div>

            <div className={form.input}>
              <Select
                placeholder={I18n.t('order.choose_delivery_city')}
                noOptionsMessage={() => null}
                classNamePrefix="react-select"
                isClearable={true}
                value={dictionaries.delivery_cities.find(city => city.id === values.delivery_city_id)}
                getOptionLabel={option => option.title}
                getOptionValue={option => option.id}
                onChange={selectedCity => {
                  // console.log(selectedCity)
                  if (selectedCity) {
                    // setCity(selectedCity)
                    setValues({
                      ...values,
                      delivery_city_id: selectedCity.id,
                      delivery_option: (selectedCity.door ? 'door' : 'storage')
                    })
                  } else {
                    // setCity()
                    setValues({
                      ...values,
                      delivery_city_id: '',
                      delivery_option: ''
                    })
                  }
                }}
                options={dictionaries.delivery_cities}
              />
            </div>
          </label>

          <Errors errors={errors.delivery_city} />
        </div>
      }

      {isInternational() &&
        <>
          <div className={form.item}>
            <label>
              <div className={form.label}>
                {I18n.t('order.cart.shipping.address.zip')}
              </div>

              <div className={form.input}>
                <input
                  type="text"
                  value={values.zip}
                  name="zip"
                  onChange={handleInputChange}
                />
              </div>
            </label>

            <Errors errors={errors.zip} />
          </div>

          <div className={form.item}>
            <label>
              <div className={form.label}>
                {I18n.t('order.cart.shipping.address.country')}
              </div>

              <div className={form.input}>
                <input
                  type="text"
                  value={values.country}
                  name="country"
                  onChange={handleInputChange}
                />
              </div>
            </label>

            <Errors errors={errors.country} />
          </div>

          <div className={form.item}>
            <label>
              <div className={form.label}>
                {I18n.t('order.cart.shipping.address.city')}
              </div>

              <div className={form.input}>
                <input
                  type="text"
                  value={values.city}
                  name="city"
                  onChange={handleInputChange}
                />
              </div>
            </label>

            <Errors errors={errors.city} />
          </div>
        </>
      }

      {city &&
        <div className={form.radio}>
          {city.door &&
            <label>
              <input
                type="radio"
                name="delivery_option"
                checked={values.delivery_option === 'door'}
                onChange={() => setValues({ ...values, delivery_option: 'door' })}
              />
              Доставка до двери ({city.door_days} дн.)
            </label>
          }

          {city.storage &&
            <label>
              <input
                type="radio"
                name="delivery_option"
                checked={values.delivery_option === 'storage'}
                onChange={() => setValues({ ...values, delivery_option: 'storage' })}
              />
              Доставка до точки выдачи ({city.storage_days})
            </label>
          }
        </div>
      }

      {(isDoor() || isInternational()) &&
        <>
          <div className={form.item}>
            <label>
              <div className={form.label}>
                {I18n.t('order.cart.shipping.address.street')}
              </div>

              <div className={form.input}>
                <input
                  type="text"
                  value={values.street}
                  name="street"
                  onChange={handleInputChange}
                />
              </div>
            </label>

            <Errors errors={errors.street} />
          </div>

          <div className={styles.ha}>
            <div className={classNames(form.item, styles.hai)}>
              <label>
                <div className={form.label}>
                  {I18n.t('order.cart.shipping.address.number')}
                </div>

                <div className={classNames(form.input, styles.hai)}>
                  <input
                    type="text"
                    value={values.house}
                    name="house"
                    onChange={handleInputChange}
                  />
                </div>
              </label>

              <Errors errors={errors.house} />
            </div>

            <div className={classNames(form.item, styles.hai)}>
              <label>
                <div className={form.label}>
                  {I18n.t('order.cart.shipping.address.appartment')}
                </div>

                <div className={classNames(form.input, styles.hai)}>
                  <input
                    type="text"
                    value={values.appartment}
                    name="appartment"
                    onChange={handleInputChange}
                  />
                </div>
              </label>

              <Errors errors={errors.appartment} />
            </div>
          </div>
        </>
      }
    </div>
  )
}
