import { createContext, useContext } from 'react'
import { CartStore } from './store'

// eslint-disable-next-line @typescript-eslint/consistent-type-assertions
export const CartContext = createContext({} as CartStore)

export function useCartContext(): CartStore {
  return useContext(CartContext)
}
