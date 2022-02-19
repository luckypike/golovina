import { FC, useEffect } from "react";
import { observer } from "mobx-react-lite";
import axios from "axios";
import { useTranslations } from "next-intl";
import Head from "next/head";

import { useCartContext } from "./context";
import { CartData } from "./models";
import { OrderItems } from "./OrderItems";
import { PromoCode } from "./PromoCode";
import { Summary } from "./Summary";

import s from './index.module.css'
import sb from '../../css/buttons.module.css'

export const Cart: FC = observer(() => {
  const t = useTranslations('Cart');
  const store = useCartContext()
  const { order, reload } = store

  useEffect(() => {
    const _fetch = async () => {
      const { data } = await axios.get<CartData>('/cart')
      store.setData(data)
    }

    if (reload) {
      _fetch()
    }

  }, [store, reload])

  return (
    <div className={s.root}>
      <Head>
        <title>{t('title')}</title>
      </Head>

      <div className={s.title}>
        <h1>{t('title')}</h1>
      </div>

      <div className={s.main}>
        <div className={s.order_items}>
          <OrderItems />
        </div>

        {order &&
          <div className={s.aside}>
            <div className={s.promo_code}>
              <PromoCode />
            </div>

            <div className={s.summary}>
              <Summary />
            </div>

            <div>
              <button className={sb.main} type="button">{t('checkout')}</button>
            </div>
          </div>
        }
      </div>
    </div>
  )
})
