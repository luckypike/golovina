import { createContext, useContext } from 'react'
import { CartStore } from './store'

export const CartContext = createContext({} as CartStore)

export function useCartContext() {
  return useContext(CartContext)
}
