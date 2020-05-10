import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

import { useI18n } from '../../I18n'

import styles from './UserAddresses.module.css'

UserAddresses.propTypes = {
  addresses: PropTypes.array.isRequired,
  cities: PropTypes.array.isRequired,
  locale: PropTypes.string.isRequired,
  values: PropTypes.object.isRequired,
  setNewAddress: PropTypes.func.isRequired,
  setValues: PropTypes.func.isRequired
}

export default function UserAddresses ({ addresses, cities, setNewAddress, locale, setValues, values }) {
  const I18n = useI18n(locale)

  const [active, setActive] = useState()

  const handleClick = address => {
    setActive(address.id)
    setValues({
      ...values,
      user_address_id: address.id,
      delivery: address.delivery,
      delivery_option: address.delivery_option,
      delivery_city_id: address.delivery_city_id,
      country: address.country,
      city: address.city,
      street: address.street,
      house: address.house,
      appartment: address.appartment
    })
  }

  useEffect(() => {
    if (values.user_address_id !== active) {
      setActive(values.user_address_id)
    }
  }, [values.user_address_id])

  return (
    <div className={styles.addresses}>
      <div className={styles.title}>
        <strong>
          Доставка на ваш адрес
        </strong>

        <div className={styles.desc}>
          {I18n.t('order.cart.shipping.russia.desc')}
        </div>
      </div>

      {addresses.map(address =>
        <div
          key={address.id}
          className={classNames(styles.address, { [styles.active]: active === address.id })}
          onClick={() => handleClick(address)}
        >
          <UserAddress
            address={address}
            city={cities.find(c => c.id === address.delivery_city_id)}
          />
        </div>
      )}

      <div
        className={styles.new}
        onClick={() => {
          setValues({
            ...values,
            delivery: 'russia',
            delivery_option: '',
            street: '',
            house: '',
            appartment: ''
          })
          setNewAddress(true)
        }}
      >
        <span>
          Новый адрес доставки
        </span>
      </div>
    </div>
  )
}

UserAddress.propTypes = {
  address: PropTypes.object,
  city: PropTypes.object
}

function UserAddress ({ address, city }) {
  const isInternational = () => address.delivery === 'international'
  const isDoor = () => address.delivery_option === 'door'

  return (
    <div>
      {isInternational() && `${address.country}, ${address.city}, `}
      {!isInternational() && `${city.title}, `}
      {(isInternational() || isDoor()) ? `${address.street}, ${address.house} - ${address.appartment}` : 'пункт выдачи'}
    </div>
  )
}
