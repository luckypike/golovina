import { FC } from "react";
import { observer } from "mobx-react-lite";
import { useTranslations } from "next-intl";

import { useCartContext } from "../context";

import s from './index.module.css'
import { Price } from "../../Price";

export const Summary: FC = observer(() => {
  const t = useTranslations('Cart');
  const { order } = useCartContext()

  if (!order) return null

  return (
    <div>
      <h2 className={s.title}>{t('summary.title')}</h2>

      <div className={s.dl}>
        <div className={s.dt}>{t('summary.order_items')}</div>
        <div className={s.dd}><Price price={order.price} priceFinal={order.price_final} /></div>
      </div>

      <div className={s.dl}>
        <div className={s.dt}>{t('summary.delivery.russia.title')}</div>
        <div className={s.dd}>{t('summary.delivery.russia.value')}</div>
      </div>

      <div className={s.dl}>
        <div className={s.dt}>{t('summary.delivery.international.title')}</div>
        <div className={s.dd}>{t('summary.delivery.international.value')}</div>
      </div>
    </div>
  )
})
