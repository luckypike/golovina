import { FC, useEffect, useState } from 'react'
import { useTranslations } from 'next-intl'
import Head from 'next/head'
import cc from 'classcat'
import axios from 'axios'

import { RefundData, RefundsData } from './models'
import { DashbordTabs } from '../Tabs'

import s from './index.module.css'
import sb from '../../../css/buttons.module.css'
import { priceFormat } from '../../Price'

export const DashbordRefunds: FC = () => {
  const t = useTranslations('Dashboard.Refunds')

  const [refunds, setRefunds] = useState<RefundData[]>()

  useEffect(() => {
    const _fetch = async (): Promise<void> => {
      const { data } = await axios.get<RefundsData>('/dashboard/refunds')
      setRefunds(data.refunds)
    }

    void _fetch()
  }, [])

  return (
    <div className={s.root}>
      <Head>
        <title>{t('title')}</title>
      </Head>

      <DashbordTabs />

      <h1 className={s.title}>{t('title')}</h1>

      <div className={s.container}>
        {!refunds && <div>{t('loading')}</div>}

        {refunds && (
          <div>
            {refunds.map((refund) => (
              <DashbordRefund key={refund.id} refund={refund} />
            ))}
          </div>
        )}
      </div>
    </div>
  )
}

const DashbordRefund: FC<{ refund: RefundData }> = ({ refund }) => {
  const t = useTranslations('Dashboard.Refunds')

  const [toggle, setToggle] = useState(false)
  const [state, setState] = useState<'archived' | 'active'>(refund.state)

  const handleArchive = async (e: React.MouseEvent<HTMLButtonElement>, id: number): Promise<void> => {
    e.stopPropagation()

    try {
      await axios.post(`/dashboard/refunds/${id}/archive`)
      setState('archived')
    } catch {}
  }

  return (
    <div className={s.refund}>
      <div className={s.handle} onClick={() => setToggle(!toggle)}>
        <div className={s.order}>
          <div className={cc([s.status, s[state]])}>{t(`state.${state}`)}</div>

          <div className={s.order}>№ {refund.order_id}</div>

          <div className={s.created_at}>{refund.created_at_fancy}</div>
        </div>

        <div className={s.what}>
          {t('what', {
            count: refund.refund_order_items.length,
            amount: priceFormat(refund.refund_order_items.map((i) => i.order_item.amount).reduce((a, b) => a + b, 0)),
          })}
        </div>

        {state !== 'archived' && (
          <div className={s.archive}>
            <button
              type="button"
              className={cc([sb.main, sb.s])}
              onClick={async (e) => await handleArchive(e, refund.id)}
            >
              {t('archive')}
            </button>
          </div>
        )}
      </div>

      {toggle && (
        <>
          <div className={s.details}>
            {t('full_name')}: {refund.user.full_name}
            <br />
            {t('phone')}: <a href={`tel:${refund.user.phone}`}>{refund.user.phone}</a>
            <br />
            {t('email')}: {refund.user.email}
            <br />
            {`${t('reason.title')}`}: {t(`reason.${refund.reason}`)}
            {refund.reason === 'other' && (
              <>
                <br />
                Описание: {refund.detail}
              </>
            )}
          </div>

          {refund.refund_order_items.map((refunOrderItem) => (
            <div key={refunOrderItem.id} className={s.item}>
              <div>
                <div className={s.image}>
                  {refunOrderItem.order_item.variant.image && (
                    // eslint-disable-next-line @next/next/no-img-element
                    <img
                      src={refunOrderItem.order_item.variant.image.src}
                      alt={refunOrderItem.order_item.variant.title}
                    />
                  )}
                </div>
              </div>

              <div>
                <strong>{refunOrderItem.order_item.variant.title}</strong>
                <br />
                {t('size')}: {refunOrderItem.order_item.size.title}
                <br />
                {t('color')}: {refunOrderItem.order_item.variant.color.title}
              </div>
            </div>
          ))}
        </>
      )}
    </div>
  )
}
