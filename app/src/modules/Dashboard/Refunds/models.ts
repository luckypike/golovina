export interface RefundsData {
  refunds: RefundData[]
}

export interface RefundData {
  id: number
  order_id: number
  created_at_fancy: string
  state: 'active' | 'archived'
  reason: string
  detail: string
  user: {
    full_name: string
    phone: string
    email: string
  }
  refund_order_items: RefundOrderItemData[]
}

export interface RefundOrderItemData {
  id: number
  order_item: {
    id: number
    amount: number
    size: {
      id: number
      title: string
    }
    variant: {
      title: string
      color: {
        id: number
        title: string
      }
      image?: {
        id: number
        src: string
      }
    }
  }
}
