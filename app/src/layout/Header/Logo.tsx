import { FC } from 'react'

import LogoImg from './logo.svg'

import s from './Logo.module.css'
import Link from 'next/link'
import { useRouter } from 'next/router'

export const Logo: FC = () => {
  const router = useRouter()

  return (
    <>
      {router.asPath === '/' && (
        <div className={s.root}>
          <LogoImg className={s.svg} />
        </div>
      )}

      {router.asPath !== '/' && (
        <Link href="/">
          <a className={s.root}>
            <LogoImg className={s.svg} />
          </a>
        </Link>
      )}
    </>
  )
}
