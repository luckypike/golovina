import { FC, useEffect } from "react";
import { observer } from "mobx-react-lite";
import axios from "axios";
import { useTranslations } from "next-intl";
import { useRouter } from "next/router";
import Head from "next/head";

import { useCartContext } from "./context";
import { useRootContext } from "../../services/useRootContext";
import { CartData } from "./models";
import { OrderItems } from "./OrderItems";
import { PromoCode } from "./PromoCode";
import { Summary } from "./Summary";

import s from './index.module.css'
import sb from '../../css/buttons.module.css'
import { Login } from "./Login";


export const Cart: FC = observer(() => {
  const t = useTranslations('Cart');
  const store = useCartContext()
  const { isAuth } = useRootContext()
  const router = useRouter()
  const { order, reload, step, setStep } = store

  useEffect(() => {
    const _fetch = async () => {
      const { data } = await axios.get<CartData>('/cart')
      store.setData(data)
    }

    if (!isAuth) {
      router.replace('/')
    } else if (reload) {
      _fetch()
    }
  }, [store, reload, isAuth, router])

  return (
    <div className={s.root}>
      <Head>
        <title>{t('title')}</title>
      </Head>

      <div className={s.title}>
        <h1>{t('title')}</h1>
      </div>

      {order &&
        <div className={s.main}>
          <div className={s.order_items}>
            <OrderItems />
          </div>

          <div className={s.aside}>
            {step === 'cart' &&
              <>
                <div className={s.promo_code}>
                  <PromoCode />
                </div>

                <div className={s.summary}>
                  <Summary />
                </div>

                <div>
                  <button className={sb.main} type="button" onClick={() => setStep('login')}>{t('login')}</button>
                </div>
              </>
            }

            {step === 'login' &&
              <>
                <Login />

                <div>
                  <button className={sb.main} type="button" onClick={() => setStep('checkout')}>{t('checkout')}</button>
                </div>
              </>
            }

          </div>
        </div>
      }
    </div>
  )
})
