export interface CartData {
  order: OrderData
  order_items: OrderItemData[]
}

export interface OrderData {
  id: number
  price: number
  price_final: number
  promo_code?: {
    id: number
    title: string
  }
}

export interface OrderItemData {
  id: number
  size: {
    id: number
    title: string
  }
  quantity: number
  price: number
  price_final: number
  variant: {
    title: string
    color: {
      id: number
      title: string
    }
    image: {
      id: number
      src: string
    }
  }
}

export type Step = 'cart' | 'login' | 'checkout'
