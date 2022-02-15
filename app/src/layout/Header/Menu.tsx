import { Dispatch, FC, SetStateAction, useMemo, useState } from 'react'
import cc from 'classcat'
import { useRootContext } from '../../services/useRootContext'

import s from './Menu.module.css'
import { useTranslations } from 'next-intl'
import AnimateHeight from 'react-animate-height'
import { observer } from 'mobx-react-lite'
import Link from 'next/link'

export const Menu: FC = observer(() => {
  const t = useTranslations('Menu');
  const rootStore = useRootContext()
  const { layoutStore, sessionData, isAuth, isEditor } = rootStore
  const [section, setSection] = useState<string>()

  const nav = useMemo(() => {
    return [...sessionData.categories, ...sessionData.themes].sort((a, b) => a.weight - b.weight)
  }, [sessionData.categories, sessionData.themes])

  return (
    <div className={cc([s.root, { [s.active]: layoutStore.activeNav }])}>
      <div className={s.close} onClick={() => layoutStore.setActiveNav(false)}>
        <svg viewBox="0 0 16 16">
          <line x1="1" y1="1" x2="15" y2="15" />
          <line x1="1" y1="15" x2="15" y2="1" />
        </svg>
      </div>

      {nav.length > 0 &&
      <Section setSection={setSection} section={section} name="catalog" duration={600}>
        {nav.map(n =>
          <div key={n.id} className={s.sub}><a href={`/catalog/${n.slug}`}>{n.title}</a></div>
        )}
        <div className={s.sub}><a href="/catalog/all">{t('catalog.all')}</a></div>
      </Section>
      }

      <Section setSection={setSection} section={section} name="about" duration={400}>
        <div className={s.sub}><Link href="/about">{t('about.phil')}</Link></div>
        <div className={s.sub}><a href="/collections">{t('about.collections')}</a></div>
        <div className={s.sub}><Link href="/contacts">{t('about.contacts')}</Link></div>
      </Section>

      <Section setSection={setSection} section={section} name="service" duration={350}>
        <div className={s.sub}><a href="/service/delivery">{t('service.delivery')}</a></div>
        <div className={s.sub}><a href="/service/return">{t('service.return')}</a></div>
      </Section>

      <div className={s.section}>
        <div className={s.title}>
          {isAuth &&
            <a href="/account">{t('account')}</a>
          }

          {!isAuth &&
            <a href="/login">{t('login')}</a>
          }
        </div>
      </div>

      {isEditor &&
        <Section setSection={setSection} section={section} name="admin" duration={450}>
          <div className={s.sub}><a href="/dashboard">Заказы и возвраты</a></div>
          <div className={s.sub}><a href="/dashboard/catalog">Категории и товары</a></div>
          <div className={s.sub}><a href="/kits/control">Образы</a></div>
          <div className={s.sub}><a href="/colors">Цвета</a></div>
          <div className={s.sub}><a href="/slides">Слайды</a></div>
          <div className={s.sub}><a href="/statistics">Статистика</a></div>
        </Section>
      }
    </div>
  )
})


const Section: FC<{ section: string | undefined, name: string, setSection: Dispatch<SetStateAction<string | undefined>>, duration: number }> = ({ section, setSection, name, children, duration }) => {
  const t = useTranslations('Menu');
  const isActive = useMemo(() => section === name, [section, name])

  return (
    <div className={cc([s.section, { [s.active]: isActive }])}>
      <div className={s.title} onClick={() => setSection(isActive ? undefined : name)}>
        {t(`${name}.title`)}
        <Arr />
      </div>

      {children &&
        <AnimateHeight className={s.subs} duration={duration} height={isActive ? 'auto' : 0}>
          {children}
        </AnimateHeight>
      }
    </div>
  )
}

const Arr: FC = () => {
  return (
    <svg viewBox="0 0 10 20" className={s.arr}>
      <polyline points="1 8 5 12 9 8" />
    </svg>
  )
}
