import React, { useEffect, useState } from 'react'
import axios from 'axios'

import { path } from '../Routes'

import page from '../Page'
import styles from './Index.module.css'
import form from '../Form.module.css'

export default function Index (props) {
  const [orders, setOrders] = useState()
  const [active, setActive] = useState(false)

  useEffect(() => {
    const _loadAsyncData = async () => {
      const { data: { orders } } = await axios.get(path('refunds_path', { format: 'json' }))
      setOrders(orders)
    }

    _loadAsyncData()
  }, [])

  return (
    <div className={page.gray}>
      <div className={page.title}>
        <h1>Возврат</h1>
      </div>

      <form className={form.form}>
        {orders &&
          <div className={form.input_input}>
            <select name="order_id" onChange={(option) => setActive(option.target.value)} value={active}>
              <option />
              {orders.map(order =>
                <option key={order.id} value={order.id}>{order.id}</option>
              )}
            </select>
          </div>
        }
      </form>
    </div>
  )
}
