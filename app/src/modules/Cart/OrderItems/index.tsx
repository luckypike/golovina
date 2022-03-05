import { FC } from "react";
import axios from "axios";
import { observer } from "mobx-react-lite";
import { useTranslations } from "next-intl";

import { useCartContext } from "../context";
import { Price } from "../../Price";

import s from './index.module.css'

export const OrderItems: FC = observer(() => {
  const t = useTranslations('Cart');
  const { order_items, setStep, step, setReload } = useCartContext()

  const handleDelete = async (order_item_id: number) => {
    console.log(order_item_id)
    try {
      await axios.delete(`/cart/order_items/${order_item_id}`)
      setReload(true)
    } catch {
      // setError('title', { message: t('arghh') })
    }
  }

  return (
    <div>
      {order_items?.map(order_item =>
        <div key={order_item.id} className={s.item}>
          <div className={s.image}>
            <img src={order_item.variant.image.src} alt={order_item.variant.title} />
          </div>

          <div className={s.main}>
            <div className={s.title}>
              {order_item.variant.title}
            </div>

            <div className={s.price}>
              <Price price={order_item.price} priceFinal={order_item.price_final} />
            </div>

            <div className={s.color}>
              {t('color')}: {order_item.variant.color.title}
            </div>

            <div className={s.size}>
              {t('size')}: {order_item.size.title}
            </div>

            <div className={s.qnt}>
              {t('qnt')}: {order_item.quantity}
            </div>

            {step === 'cart' &&
              <div>
                <button onClick={() => handleDelete(order_item.id)} className={s.delete} type="button">{t('delete')}</button>
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
