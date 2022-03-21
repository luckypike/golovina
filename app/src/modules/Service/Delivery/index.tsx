import { FC } from 'react'
import { useTranslations } from 'next-intl'
import Head from 'next/head'
import { useRouter } from 'next/router'

import { DeliveryRu } from './ru'
import { DeliveryEn } from './en'

import s from './index.module.css'

export const Delivery: FC = () => {
  const t = useTranslations('Service.Delivery')
  const router = useRouter()

  return (
    <div className={s.root}>
      <Head>
        <title>{t('title')}</title>
      </Head>

      <h1 className={s.title}>{t('title')}</h1>

      {router.locale === 'ru' && <DeliveryRu />}
      {router.locale === 'en' && <DeliveryEn />}
    </div>
  )
}
