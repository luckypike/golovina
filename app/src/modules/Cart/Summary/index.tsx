import { FC } from 'react'
import { observer } from 'mobx-react-lite'
import { useTranslations } from 'next-intl'

import { useCartContext } from '../context'
import { Price } from '../../Price'
import { useRootContext } from '../../../services/useRootContext'

import s from './index.module.css'
import sb from '../../../css/buttons.module.css'

export const Summary: FC = observer(() => {
  const t = useTranslations('Cart.Summary')
  const { order, setStep } = useCartContext()
  const { isAuth } = useRootContext()

  if (order == null) return null

  return (
    <div>
      <h2 className={s.title}>{t('title')}</h2>

      <div className={s.dl}>
        <div className={s.dt}>{t('order_items')}</div>
        <div className={s.dd}>
          <Price price={order.price} priceFinal={order.price_final} />
        </div>
      </div>

      <div className={s.dl}>
        <div className={s.dt}>{t('delivery.russia.title')}</div>
        <div className={s.dd}>{t('delivery.russia.value')}</div>
      </div>

      <div className={s.dl}>
        <div className={s.dt}>{t('delivery.international.title')}</div>
        <div className={s.dd}>{t('delivery.international.value')}</div>
      </div>

      <div className={s.submit}>
        <button className={sb.main} type="button" onClick={() => setStep(isAuth ? 'checkout' : 'login')}>
          {t('submit')}
        </button>
      </div>
    </div>
  )
})
