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
import { Login } from "./Login";
import { Checkout } from "./Checkout";
import { Delivery } from "./Delivery";


import s from './index.module.css'
// import sb from '../../css/buttons.module.css'
import { Pay } from "./Pay";

export const Cart: FC = observer(() => {
  const t = useTranslations('Cart');
  const store = useCartContext()
  const { sessionData: { user } } = useRootContext()
  const router = useRouter()
  const { order, reload, step, setStep, order_items } = store

  useEffect(() => {
    // TODO: Find another way for this
    if(router.asPath === '/cart#checkout') {
      setStep('checkout')
    }
  }, [router, setStep])

  useEffect(() => {
    const _fetch = async () => {
      const { data } = await axios.get<CartData>('/cart')
      store.setData(data)
    }

    if (user.id < 1) {
      router.replace('/')
    } else if (reload) {
      _fetch()
    }
  }, [store, reload, user, router])

  return (
    <div className={s.root}>
      <Head>
        <title>{t('title')}</title>
      </Head>

      <div className={s.title}>
        <h1>{t('title')}</h1>
      </div>

      {order && order_items.length > 0 &&
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
              </>
            }

            {step === 'login' &&
              <Login />
            }

            {step === 'delivery' &&
              <Delivery />
            }

            {step === 'checkout' &&
              <Checkout />
            }

            {step === 'pay' &&
              <Pay />
            }
          </div>
        </div>
      }
    </div>
  )
})
