import { FC, useEffect, useMemo, useState } from 'react'
import axios from 'axios'
import { SubmitHandler, useForm } from 'react-hook-form'
import { useTranslations } from 'next-intl'
import cc from 'classcat'

import { OrderData, Values } from './models'
import { entries } from '../../models'
import { priceFormat } from '../Price'

import s from './index.module.css'
import sf from '../../layout/form.module.css'
import sb from '../../css/buttons.module.css'

const NewRefund: FC = () => {
  const t = useTranslations('NewRefund')

  const {
    register,
    watch,
    setValue,
    handleSubmit,
    setError,
    clearErrors,
    formState: { errors, isSubmitting },
  } = useForm<Values>({ defaultValues: { order_id: '', reason: '', order_item_ids: [] } })

  const [orders, setOrders] = useState<OrderData[]>()
  useEffect(() => {
    const _fetch = async (): Promise<void> => {
      const { data } = await axios.get<{ orders: OrderData[] }>('/account/refunds')
      setOrders(data.orders)
    }

    if (!orders) {
      void _fetch()
    }
  }, [orders])

  const watchOrderId = watch('order_id')
  const watchReason = watch('reason')

  const order = useMemo(() => {
    return orders?.find((i) => i.id.toString() === watchOrderId)
  }, [orders, watchOrderId])

  useEffect(() => {
    setValue('reason', '')
    setValue('detail', '')
    setValue('order_item_ids', [])
    clearErrors()
  }, [setValue, watchOrderId, clearErrors])

  const onSubmit: SubmitHandler<Values> = async (params) => {
    try {
      const { data } = await axios.post<{ id: number }>('/account/refunds', params)
      setSubmitted(data.id)
    } catch ({
      response: {
        data: { errors: errorsData },
      },
    }) {
      entries(errorsData as Record<keyof Values, string[]>).forEach(([name, messages]) => {
        messages.map((message) => setError(name, { type: 'manual', message }))
      })
    }
  }

  const [submitted, setSubmitted] = useState<number>()

  return (
    <div className={s.root}>
      <h1 className={s.title}>{t('title')}</h1>

      {submitted !== undefined && <div className={s.submitted}>{t('submitted', { id: submitted })}</div>}

      {orders && submitted === undefined && (
        <form onSubmit={handleSubmit(onSubmit)} className={cc([sf.root, s.container])}>
          <div className={sf.el}>
            <div className={sf.lb}>{t('desc')}</div>

            <div className={sf.it}>
              <select className={sf.in} {...register('order_id')}>
                <option disabled value="" />

                {orders.map((order) => (
                  <option key={order.id} value={order.id}>
                    {t('order', { id: order.id, paid_at: order.paid_at_fancy, amount: priceFormat(order.amount) })}
                  </option>
                ))}
              </select>
            </div>
          </div>

          {order && (
            <>
              <div className={sf.el}>
                <div className={sf.lb}>{t('check')}</div>

                <div className={sf.it}>
                  <input {...register('order_item_ids')} className={s.hack} type="checkbox" value="" />

                  {order.order_items.map((orderItem) => (
                    <label key={orderItem.id} className={s.item}>
                      <div>
                        <div className={cc([sf.lb, sf.checkbox])}>
                          <input {...register('order_item_ids')} type="checkbox" value={orderItem.id} />
                        </div>
                      </div>

                      <div>
                        <div className={s.image}>
                          {orderItem.variant.image && (
                            // eslint-disable-next-line @next/next/no-img-element
                            <img src={orderItem.variant.image.src} alt={orderItem.variant.title} />
                          )}
                        </div>
                      </div>

                      <div>
                        <strong>{orderItem.variant.title}</strong>
                        <br />
                        {t('size')}: {orderItem.size.title}
                        <br />
                        {t('color')}: {orderItem.variant.color.title}
                      </div>
                    </label>
                  ))}
                </div>

                {errors.order_item_ids != null && <div className={sf.er}>{errors.order_item_ids.message}</div>}
              </div>

              <div className={sf.el}>
                <label className={sf.it}>
                  <div className={sf.lb}>{t('reason.title')}</div>

                  <select className={sf.in} {...register('reason')}>
                    <option disabled value="" />
                    {['size', 'defect', 'color', 'other'].map((reason) => (
                      <option key={reason} value={reason}>
                        {t(`reason.${reason}`)}
                      </option>
                    ))}
                  </select>
                </label>

                {errors.reason != null && <div className={sf.er}>{errors.reason.message}</div>}
              </div>

              {watchReason === 'other' && (
                <div className={sf.el}>
                  <label className={sf.it}>
                    <div className={sf.lb}>{t('detail')}</div>
                    <textarea className={sf.in} {...register('detail')} />
                  </label>

                  {errors.detail != null && <div className={sf.er}>{errors.detail.message}</div>}
                </div>
              )}

              <div>
                <button
                  className={cc([sb.main, { [sb.submitting]: isSubmitting }])}
                  disabled={isSubmitting}
                  type="submit"
                >
                  {t('submit')}
                </button>
              </div>
            </>
          )}
        </form>
      )}
    </div>
  )
}

export default NewRefund
