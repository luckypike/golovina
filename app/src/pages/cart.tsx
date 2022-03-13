import type { NextPage } from 'next'
import { useState } from 'react'

import { Cart } from '../modules/Cart'
import { CartContext } from '../modules/Cart/context'
import { CartStore } from '../modules/Cart/store'

const CartPage: NextPage = () => {
  const [store] = useState(new CartStore())

  return (
    <CartContext.Provider value={store}>
      <Cart />
    </CartContext.Provider>
  )
}

export default CartPage
