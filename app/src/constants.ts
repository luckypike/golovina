export const defaultServerSideConfig = (locale?: string): any => {
  return {
    baseURL: process.env.API_URL,
    headers: {
      'Content-Type': 'application/json',
      'X-Locale': locale ?? '',
    },
  }
}
