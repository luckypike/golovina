import { FC } from 'react'
import { useTranslations } from 'next-intl'
import Head from 'next/head'
import { useRouter } from 'next/router'

import { useRootContext } from '../../../services/useRootContext'
import { ReturnRu } from './ru'
import { ReturnEn } from './en'

import s from './index.module.css'
import sb from '../../../css/buttons.module.css'

export const Return: FC = () => {
  const t = useTranslations('Service.Return')
  const router = useRouter()
  const { isAuth } = useRootContext()

  const handleRefundClick = (): void => {
    void router.push('/account/refund')
  }

  const handleLoginClick = (): void => {
    window.location.href = '/login'
  }

  return (
    <div className={s.root}>
      <Head>
        <title>{t('title')}</title>
      </Head>

      <h1 className={s.title}>{t('title')}</h1>

      {router.locale === 'ru' && <ReturnRu />}
      {router.locale === 'en' && <ReturnEn />}

      <div className={s.refund}>
        {isAuth && (
          <button className={sb.main} onClick={handleRefundClick}>
            {t('refund')}
          </button>
        )}
        {!isAuth && (
          <button className={sb.main} onClick={handleLoginClick}>
            {t('login')}
          </button>
        )}
      </div>
    </div>
  )
}
