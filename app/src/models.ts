export interface User {
  id: number
  email: string
}

export const entries = Object.entries as <T>(o: T) => [Extract<keyof T, string>, T[keyof T]][]

export type ErrorsData = Record<string, string[]>
