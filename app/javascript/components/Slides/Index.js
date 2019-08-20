import React from 'react'
import PropTypes from 'prop-types'

import { useI18n } from '../I18n'

Index.propTypes = {
  locale: PropTypes.string
}

export default function Index ({ locale }) {
  const I18n = useI18n(locale)

  return (
    <div>
      {I18n.t('slides.title')}
    </div>
  )
}
