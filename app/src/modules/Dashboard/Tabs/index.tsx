import { FC } from 'react'
import Link from 'next/link'
import { useTranslations } from 'next-intl'

import s from './index.module.css'

export const DashbordTabs: FC = () => {
  const t = useTranslations('Dashboard.Tabs')

  return (
    <div className={s.root}>
      <a href="/dashboard">{t('orders')}</a>
      <a href="/dashboard/archived">{t('archived')}</a>
      <Link href="/dashboard/refunds">{t('refunds')}</Link>
      <a href="/dashboard/cart">{t('carts')}</a>
      <a href="/dashboard/wishlists">{t('wishlists')}</a>
      <a href="/dashboard/users">{t('users')}</a>
    </div>
  )
}
