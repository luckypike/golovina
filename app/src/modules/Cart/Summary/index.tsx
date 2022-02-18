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
      <h2>{t('summary')}</h2>

      <div>
        <div></div>
        <div><Price price={order.price} priceFinal={order.price_final} /></div>
      </div>
    </div>
  )
})
