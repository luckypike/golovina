import { FC } from 'react'
import axios from 'axios'
import { observer } from 'mobx-react-lite'
import { useTranslations } from 'next-intl'

import { useCartContext } from '../context'
import { Price } from '../../Price'

import s from './index.module.css'

export const OrderItems: FC = observer(() => {
  const t = useTranslations('Cart')
  const { orderItems, setStep, step, setReload } = useCartContext()

  const handleDelete = async (orderItemId: number): Promise<void> => {
    console.log(orderItemId)
    try {
      await axios.delete(`/cart/order_items/${orderItemId}`)
      setReload(true)
    } catch {
      // setError('title', { message: t('arghh') })
    }
  }

  return (
    <div>
      {orderItems?.map(orderItem =>
        <div key={orderItem.id} className={s.item}>
          <div className={s.image}>
            <img src={orderItem.variant.image.src} alt={orderItem.variant.title} />
          </div>

          <div className={s.main}>
            <div className={s.title}>
              {orderItem.variant.title}
            </div>

            <div className={s.price}>
              <Price price={orderItem.price} priceFinal={orderItem.price_final} />
            </div>

            <div className={s.color}>
              {t('color')}: {orderItem.variant.color.title}
            </div>

            <div className={s.size}>
              {t('size')}: {orderItem.size.title}
            </div>

            <div className={s.qnt}>
              {t('qnt')}: {orderItem.quantity}
            </div>

            {step === 'cart' &&
              <div>
                <button onClick={async () => await handleDelete(orderItem.id)} className={s.delete} type="button">{t('delete')}</button>
              </div>
            }
          </div>
        </div>
      )}

      {step !== 'cart' &&
        <div>
          <button onClick={() => setStep('cart')} className={s.button} type="button">{t('change')}</button>
        </div>
      }
    </div>
  )
})
