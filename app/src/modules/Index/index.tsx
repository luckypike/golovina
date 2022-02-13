import axios from "axios";
import Head from "next/head";
import { FC } from "react";
import { defaultServerSideConfig } from "../../constants";
import { IndexData } from "./models";
import { Slides } from "./Slides";

import s from './index.module.css'
import { Instagram } from "./Instagram";


export const Index: FC = () => {
  return (
    <div className={s.root}>
      <Head>
        <meta name="facebook-domain-verification" content="gq1zcts3t1t3zp0vuyh34su8tqowbk" />
      </Head>

      <div className={s.slides}>
        <Slides />
      </div>

      <Instagram />
    </div>
  )
}

export const getIndexData = async (locale?: string) => {
  const { data } = await axios.get<IndexData>('/pages/index', defaultServerSideConfig(locale))

  return data
}
