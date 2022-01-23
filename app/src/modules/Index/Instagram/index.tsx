import { FC } from "react";
import { observer } from "mobx-react-lite";
import { useIndexContext } from "../context";
import cc from 'classcat'

import s from './index.module.css';
import InstaIcon from './insta.svg'
import { InstagramData } from "../models";

export const Instagram: FC = observer(() => {
  const { instagram } = useIndexContext()

  return (
    <div className={s.root}>
      <a target="_blank" href="https://www.instagram.com/golovinamari_/" rel="noopener noreferrer" className={s.link}>
        <InstaIcon />
        golovinamari_
      </a>

      <div className={s.items}>
        {instagram.map(item =>
          <Item key={item.id} item={item} />
        )}
      </div>
    </div>
  )
})

const Item: FC<{ item: InstagramData }> = ({ item }) => {
  return (
    <a className={s.item} target="_blank" href={item.permalink} rel="noopener noreferrer">
      {item.media_type === 'VIDEO' &&
        <video autoPlay loop muted>
          <source src={item.media_url} />
        </video>
      }

      {(item.media_type === 'CAROUSEL_ALBUM' || item.media_type === 'IMAGE') &&
        <img src={item.media_url} alt="Instapost" />
      }
  </a>
  )
}
