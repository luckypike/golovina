import { FC, useState } from "react";
import cc from 'classcat'
import { useTranslations } from "next-intl";

import s from './index.module.css'

export const AppleID: FC<{ returnUri: string }> = ({ returnUri }) => {
  const url = `https://appleid.apple.com/auth/authorize?scope=name%20email&client_id=${process.env.NEXT_PUBLIC_APPLE_CLIENT_ID}&redirect_uri=${process.env.NEXT_PUBLIC_APPLE_REDIRECT_URI}%3Freturn_uri=${returnUri}&response_type=code%20id_token&response_mode=form_post`

  console.log(new URL(url))

  const t = useTranslations('AppleID')
  const [clicked, setClicked] = useState(false)

  const handleClick = (e: React.MouseEvent<HTMLElement>) => {
    if (clicked) {
      e.preventDefault()
    } else {
      setClicked(true)
    }
  }

  return (
    <div className={s.root}>
      <a className={cc([s.apple, { [s.disabled]: clicked }])} onClick={handleClick} href={url}>
        {t('sign_in')}
      </a>
    </div>
  )
}
