import React from 'react'

import WWImg from './whole-world.png'

import page from '../Page'
import I18n from '../I18n'
import styles from './About.module.css'

export default function About () {
  return (
    <div className={page.root}>
      <div className={page.text}>
        {I18n.locale === 'en' && <EN />}
        {I18n.locale === 'ru' && <RU />}
      </div>
    </div>
  )
}

function RU () {
  return (
    <>
      <p>
        Golovina Mari — бренд о женской свободе, силе, легкости, зрелости, притягательности и самоиронии.
      </p>

      <p>
        Интересные детали и крой, узнаваемый почерк. Цвета — нетривиальные, монохромные, уверенные. Формы — чутко следуют за красотой и женственностью. Основа каждой коллекции — универсальные, продуманные вещи, которые формируются в понятный и качественный гардероб вне времени. Вещи, которые способны изменить то, как мы себя ощущаем. Сделать нас уверенными. Раскрепостить мысли. Наполнить энергией жизни.
      </p>

      <figure className={styles.quote}>
        <blockquote>
          «Каждая женщина уникальна и красива, просто не каждая из нас умеет эту красоту показать окружающим. Я получаю огромное удовольствие, когда благодаря моей вещи женщина преображается. Вещь ее не затмевает, не забирает на себя внимание, а лишь подчеркивает красоту. Это магия, которая происходит без слов. Все это в совокупности раскрывает женщину, и она сама становится вдохновителем для других».
        </blockquote>
        <figcaption>— Мария Головина.</figcaption>
      </figure>

      <div>
        <img className={styles.ww} src={WWImg} />
      </div>

      <p>
        Из разнообразия возникает совершенная гармония. Для нас единое — в разном. Мы изнутри — это множество цветных стеклышек, каждое — красивое, особенное, уязвимое и сильное. Но только вместе они образуют неповторимый узор и сияют всеми красками.
      </p>

      <p>
        Духовный и чувственный опыт, интеллект и эмоции, спонтанность. Люди и большие города, новые возможности и энергия жизни. Мы черпаем вдохновение в многоликости. Мы создаем единую форму из совершенно разных ритмов этого мира.
      </p>

      <p>
        THE WHOLE WORLD IN YOU
      </p>
    </>
  )
}

function EN () {
  return (
    <>
      <p>
        Golovina Mari is a brand devoted to women and their freedom, strength, light, maturity, magnetism, and humor.
      </p>

      <p>
        Intriguing details and cuts combine to form an unmistakable style. The colors are serious, monochromatic, and confident. Lines and shapes highlight the wearer’s beauty and femininity. Each collection focuses on universal and thoughtful items that come together to form a timeless wardrobe of quality essentials. These are clothes that can change how we feel. Make us confident. Open our minds. Fill us with a lust for life.
      </p>

      <figure className={styles.quote}>
        <blockquote>
          “Every woman is unique and beautiful, but not all of us have a chance to discover our best face to show the world. I feel enormous joy when my clothes help a woman transform. No item overshadows her or calls attention to itself; instead, they highlight her natural beauty. This is a silent kind of magic. When all of these elements come together, they let a woman flourish, making her an inspiration to others.”
        </blockquote>
        <figcaption>— Мария Головина.</figcaption>
      </figure>

      <div>
        <img className={styles.ww} src={WWImg} />
      </div>

      <p>
        The brand’s basic statements. Variety creates a perfect harmony.  For us, unity comes from diversity. Inside, all of us are menageries of colored glass. Each glass is simultaneously beautiful, special, vulnerable, and strong. Still, they must come together to create a singular pattern and shine in all their glory.
      </p>

      <p>
        A spiritual and sensual experience. Intellect and emotions. Spontaneity. People and big cities; new opportunities and the lust for life. We find inspiration in the many faces we show the world. We create a single, harmonious form from the infinitude of rhythms of our world.
      </p>

      <p>
        THE WHOLE WORLD IN YOU
      </p>
    </>
  )
}
