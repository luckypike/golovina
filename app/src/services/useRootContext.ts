import { createContext, useContext } from 'react'
import { RootStore } from './stores/RootStore'

// eslint-disable-next-line @typescript-eslint/consistent-type-assertions
export const RootContext = createContext({} as RootStore)

export const useRootContext = (): RootStore => {
  return useContext(RootContext)
}
