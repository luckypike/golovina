import { FC, useEffect, useRef } from 'react'
import { observer } from 'mobx-react-lite'
import { useTranslations } from 'next-intl'

import { useCartContext } from '../context'
import { useRouter } from 'next/router'

import s from './index.module.css'

export const Pay: FC = observer(() => {
  const { order, reload } = useCartContext()
  const router = useRouter()
  const t = useTranslations('Cart.Pay')

  if (order == null || order.user == null) return null

  const formRef = useRef<HTMLFormElement>(null)
  useEffect(() => {
    if (order && !reload) formRef.current?.submit()
  }, [reload, order])

  return (
    <div>
      <form ref={formRef} action={process.env.NEXT_PUBLIC_PAYKEEPER_GAYEWAY} method="post" className={s.form}>
        <input name="sum" value={order.price_final + (order.price_delivery ?? 0)} />
        <input name="clientid" value={`${order.user.full_name} / ${order.user.id}`} />
        <input name="orderid" value={order.id} />
        <input name="lang" value={router.locale} />
        <input name="client_phone" value={order.user.phone} />
      </form>

      <div className={s.processing}>{t('processing')}</div>
    </div>
  )
})
