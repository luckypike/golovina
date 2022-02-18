import { FC, useEffect } from "react";
import axios from "axios";
import { useTranslations } from "next-intl";
import Head from "next/head";

import { useCartContext } from "./context";
import { CartData } from "./models";
import { OrderItems } from "./OrderItems";

import s from './index.module.css'

export const Cart: FC = () => {
  const t = useTranslations('Cart');
  const store = useCartContext()

  useEffect(() => {
    const _fetch = async () => {
      const { data } = await axios.get<CartData>('/cart')
      store.setData(data)
    }

    _fetch()
  }, [store])

  return (
    <div className={s.root}>
      <Head>
        <title>{t('title')}</title>
      </Head>

      <div>
        <h1>{t('title')}</h1>
      </div>

      <div className={s.main}>
        <div>
          <OrderItems />
        </div>
      </div>
    </div>
  )
}
