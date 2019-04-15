import React, { Component } from 'react'
import classNames from 'classnames'

import { YMaps} from 'react-yandex-maps';
import { Map } from 'react-yandex-maps';
import { Placemark } from 'react-yandex-maps';

import page from '../Page'
import styles from './Contacts.module.css'

class Contacts extends Component {
  state = {

  }

  render() {

    return (
      <div className={page.root}>
        <div className={page.title}>
          <h1>Места продаж</h1>
        </div>

        <div className={styles.intro}>
          <div className={styles.img} />
          <div className={styles.brand}>
            <a href={this.props.instagram} className={styles.icon}>
              <svg width="96" height="96" viewBox="0 0 96 96" fill="none" xmlns="http://www.w3.org/2000/svg">
                <g clip-path="url(#clip0)">
                <path d="M48 8.64845C60.8174 8.64845 62.3341 8.69799 67.3966 8.92854C72.0762 9.14194 74.618 9.92314 76.3099 10.5805C78.5507 11.4512 80.1493 12.4916 81.8298 14.1702C83.5103 15.8507 84.5507 17.4493 85.4195 19.69C86.0769 21.382 86.8581 23.9238 87.0715 28.6033C87.302 33.664 87.3515 35.1826 87.3515 48C87.3515 60.8174 87.302 62.334 87.0715 67.3966C86.8581 72.0762 86.0769 74.6179 85.4195 76.3099C84.5488 78.5506 83.5084 80.1492 81.8298 81.8297C80.1493 83.5103 78.5507 84.5506 76.3099 85.4194C74.618 86.0768 72.0762 86.858 67.3966 87.0714C62.336 87.302 60.8174 87.3515 48 87.3515C35.1826 87.3515 33.664 87.302 28.6034 87.0714C23.9238 86.858 21.382 86.0768 19.6901 85.4194C17.4494 84.5487 15.8507 83.5084 14.1702 81.8297C12.4897 80.1492 11.4493 78.5506 10.5805 76.3099C9.92315 74.6179 9.14195 72.0762 8.92855 67.3966C8.698 62.3359 8.64846 60.8174 8.64846 48C8.64846 35.1826 8.698 33.6659 8.92855 28.6033C9.14195 23.9238 9.92315 21.382 10.5805 19.69C11.4513 17.4493 12.4916 15.8507 14.1702 14.1702C15.8507 12.4897 17.4494 11.4493 19.6901 10.5805C21.382 9.92314 23.9238 9.14194 28.6034 8.92854C33.6659 8.69799 35.1826 8.64845 48 8.64845ZM48 0C34.9635 0 33.3287 0.0552556 28.209 0.289616C23.1007 0.52207 19.6119 1.33376 16.5576 2.5208C13.4004 3.74785 10.7234 5.38837 8.05589 8.05779C5.38838 10.7253 3.74595 13.4023 2.5208 16.5576C1.33376 19.6119 0.522071 23.1007 0.289616 28.2089C0.0552556 33.3287 0 34.9635 0 48C0 61.0365 0.0552556 62.6713 0.289616 67.791C0.522071 72.8993 1.33376 76.388 2.5208 79.4423C3.74786 82.5995 5.38838 85.2766 8.0578 87.9441C10.7272 90.6135 13.4024 92.254 16.5595 93.4811C19.6119 94.6681 23.1026 95.4798 28.2109 95.7122C33.3306 95.9466 34.9654 96.0019 48.0019 96.0019C61.0384 96.0019 62.6732 95.9466 67.793 95.7122C72.9012 95.4798 76.3919 94.6681 79.4443 93.4811C82.6015 92.254 85.2785 90.6135 87.946 87.9441C90.6154 85.2746 92.256 82.5995 93.483 79.4423C94.6701 76.3899 95.4818 72.8993 95.7142 67.791C95.9486 62.6713 96.0038 61.0365 96.0038 48C96.0038 34.9635 95.9486 33.3287 95.7142 28.2089C95.4818 23.1007 94.6701 19.61 93.483 16.5576C92.256 13.4004 90.6154 10.7234 87.946 8.05589C85.2766 5.38647 82.6015 3.74595 79.4443 2.51889C76.3881 1.33376 72.8993 0.52207 67.7911 0.289616C62.6713 0.0552556 61.0365 0 48 0Z" fill="#FAFAFA"/>
                <path d="M48 23.3522C34.3862 23.3522 23.3522 34.3881 23.3522 48C23.3522 61.6119 34.3881 72.6478 48 72.6478C61.6119 72.6478 72.6478 61.6119 72.6478 48C72.6478 34.3881 61.6138 23.3522 48 23.3522ZM48 63.9994C39.1629 63.9994 32.0006 56.8352 32.0006 48C32.0006 39.1629 39.1648 32.0006 48 32.0006C56.8352 32.0006 63.9994 39.1648 63.9994 48C63.9994 56.8371 56.8371 63.9994 48 63.9994Z" fill="#FAFAFA"/>
                <path d="M73.6233 28.1365C76.8044 28.1365 79.3833 25.5577 79.3833 22.3766C79.3833 19.1955 76.8044 16.6167 73.6233 16.6167C70.4422 16.6167 67.8634 19.1955 67.8634 22.3766C67.8634 25.5577 70.4422 28.1365 73.6233 28.1365Z" fill="#FAFAFA"/>
                </g>
                <defs>
                <clipPath id="clip0">
                <rect width="96" height="96" fill="white"/>
                </clipPath>
                </defs>
              </svg>
            </a>
            <a href={this.props.instagram} className={styles.name}>Golovina.brand</a>
          </div>
          <div className={styles.mail}>{this.props.mail}</div>
        </div>

        <div className={styles.content}>

          <div className={styles.showcase}>
            <div className={styles.img} />
          </div>
          <div className={styles.info}>
            <div className={styles.info_wrapper}>
              <div className={styles.city}>Москва</div>
              <div className={styles.address}>
                3-я улица Ямского поля, 9к5 <br/>
                Телефон: +7 985 800-07-48, +7 985 714-55-58
              </div>
              <div className={styles.schedule}>Ежедневно с 13:00 до 21:00</div>
              <div className={styles.map}>
                <YMaps>
                  <div>
                    <Map width={'100%'} defaultState={{ center: [55.7826, 37.5804], zoom: 16, width: 100 }}>
                      <Placemark defaultGeometry={[55.7826, 37.5804]} />
                    </Map>
                  </div>
                </YMaps>
              </div>
            </div>
          </div>

          <div className={styles.showcase}>
            <div className={styles.img} />
          </div>
          <div className={styles.info}>
            <div className={styles.info_wrapper}>
              <div className={styles.city}>Нижний Новгород</div>
              <div className={styles.address}>
                Ошарская, 61 <br/>
                Телефон: +7 910 134-07-77
              </div>
              <div className={styles.schedule}>Ежедневно с 12:00 до 20:00</div>
              <div className={styles.map}>
                <YMaps>
                  <div>
                    <Map width={'100%'} defaultState={{ center: [56.3112, 44.0157], zoom: 16, width: '600px'  }}>
                      <Placemark defaultGeometry={[56.3112, 44.0157]} />
                    </Map>
                  </div>
                </YMaps>
              </div>
            </div>
          </div>
        </div>
      </div>
    )
  }
}

export default Contacts
