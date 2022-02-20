import { FC } from "react";
import { observer } from "mobx-react-lite";
import Script from "next/script";
import { AppleID } from "../../AppleID";
// import { useTranslations } from "next-intl";

// import { useCartContext } from "../context";

// import s from './index.module.css'

export const Login: FC = observer(() => {
  return (
    <div>
      <AppleID returnUri="/cart" />
    </div>
  )
})
