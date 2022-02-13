export const defaultServerSideConfig = (locale?: string) => {
  return {
    baseURL: process.env.API_URL,
    headers: {
      'X-Locale': locale ?? '',
    }
  }
}
