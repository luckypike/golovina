import { FC } from 'react'
import { useTranslations } from 'next-intl'

import s from './index.module.css'

export const DashbordTabs: FC = () => {
  const t = useTranslations('Dashboard.Tabs')

  return (
    <div className={s.root}>
      <a href="/dashboard">{t('orders')}</a>
      <a href="/dashboard/archived">{t('archived')}</a>
      <a href="/dashboard/refunds">{t('refunds')}</a>
      <a href="/dashboard/cart">{t('carts')}</a>
      <a href="/dashboard/wishlists">{t('wishlists')}</a>
      <a href="/dashboard/users">{t('users')}</a>
    </div>
  )
}
