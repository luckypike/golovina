import { FC } from "react";
import { observer } from "mobx-react-lite";
import Script from "next/script";
import { AppleID } from "../../AppleID";
import { useTranslations } from "next-intl";

import { useCartContext } from "../context";
// import { useRootContext } from "../../../services/useRootContext";

import s from './index.module.css'
import sb from '../../../css/buttons.module.css'

export const Login: FC = observer(() => {
  const t = useTranslations('Cart.Login');
  const { setStep } = useCartContext()
  // const { isAuth } = useRootContext()

  return (
    <div className={s.root}>
      <div className={s.appleid}>
        <AppleID returnUri="/cart" />
      </div>

      <div className={s.desc}>
        {t('desc')}
      </div>

      <div className={s.or}>{t('or')}</div>

      <div className={s.checkout}>
        <button className={sb.main} type="button" onClick={() => setStep('checkout')}>{t('submit')}</button>
      </div>
    </div>
  )
})
