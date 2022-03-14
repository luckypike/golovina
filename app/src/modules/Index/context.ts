import { createContext, useContext } from 'react'
import { IndexStore } from './store'

// eslint-disable-next-line @typescript-eslint/consistent-type-assertions
export const IndexContext = createContext({} as IndexStore)

export function useIndexContext(): IndexStore {
  return useContext(IndexContext)
}
