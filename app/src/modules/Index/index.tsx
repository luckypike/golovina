import axios from "axios";
import { observer } from "mobx-react-lite";
import Link from "next/link";
import { FC, useEffect, useState } from "react";
import { defaultServerSideConfig } from "../../constants";
import { IndexContext, useIndexContext } from "./context";
import { IndexData } from "./models";
import { Slides } from "./Slides";
import { IndexStore } from "./store";

import s from './index.module.css'
import { Instagram } from "./Instagram";

export const Index: FC = () => {
  return (
    <div className={s.root}>
      <Slides />
      <Instagram />
    </div>
  )
}

export const getIndexData = async () => {
  const { data } = await axios.get<IndexData>('/pages/index', defaultServerSideConfig)

  return data
}
