import { FC } from "react";
import { observer } from "mobx-react-lite";
import { useTranslations } from "next-intl";

import { useCartContext } from "../context";

import s from './index.module.css'
import { Price } from "../../Price";


export const OrderItems: FC = observer(() => {
  const t = useTranslations('Cart');
  const { order, order_items } = useCartContext()

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
          </div>
        </div>
      )}
    </div>
  )
})
