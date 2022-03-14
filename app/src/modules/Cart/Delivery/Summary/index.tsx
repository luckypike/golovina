import { FC } from 'react'
import { observer } from 'mobx-react-lite'
import { useTranslations } from 'next-intl'

import { useCartContext } from '../../context'
import { Price } from '../../../Price'

import s from './index.module.css'
import { WatchDeliveryOption } from '../../models'
// import sb from '../../../css/buttons.module.css'

export const Summary: FC<{
  watchDelivery: string
  deliveryOption?: WatchDeliveryOption
}> = observer(({ watchDelivery, deliveryOption }) => {
  const t = useTranslations('Cart.Delivery.summary')
  const { order } = useCartContext()

  if (order == null) return null

  const deliveryPrice = watchDelivery === 'international' ? 2800 : deliveryOption != null ? deliveryOption.price : 0

  return (
    <>
      <div className={s.dl}>
        <div className={s.dt}>{t('order')}</div>
        <div className={s.dd}>
          <Price price={order.price_final} priceFinal={order.price_final} />
        </div>
      </div>

      {deliveryPrice > 0 && (
        <div className={s.dl}>
          <div className={s.dt}>{t(watchDelivery)}</div>
          <div className={s.dd}>
            <Price price={deliveryPrice} priceFinal={deliveryPrice} />
          </div>
        </div>
      )}

      <div className={s.dl}>
        <div className={s.dt}>{t('total')}</div>
        <div className={s.dd}>
          <Price price={order.price_final + deliveryPrice} priceFinal={order.price_final + deliveryPrice} />
        </div>
      </div>
    </>
  )
})
